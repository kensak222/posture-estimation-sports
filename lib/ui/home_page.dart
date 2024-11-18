import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posture_estimation_sports/router.dart';
import 'package:posture_estimation_sports/util/utils.dart';

import '../domain/home/video_picker_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logger.d('HomePage#build が呼ばれました');
    // videoPickerProvider の状態を監視
    final videoPickerState = ref.watch(videoPickerProvider);

    // ref.listen を使って videoPickerState の変化を監視し、遷移を処理
    // 状態が変更されたときに一度だけ反応するのみで要件的には必要十分
    ref.listen<AsyncValue<List<File>>>(videoPickerProvider, (previous, next) {
      next.when(
        data: (frames) {
          // フレームのデータが取得できた場合、遷移を試みる
          if (frames.isNotEmpty) {
            logger.d('姿勢推定画面に遷移します');
            PoseEstimationRoute($extra: frames).go(context);
          }
        },
        loading: () {
          logger.d('フレーム抽出中...');
        },
        error: (error, stack) {
          logger.e('エラーが発生しました: $error');
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: videoPickerState.when(
          data: (frames) {
            logger.d('フレームデータ: $frames');
            return OutlinedButton(
              onPressed: () async {
                logger.d('読み込みたい動画を選択 ボタンがタップされました');
                await ref
                    .read(videoPickerProvider.notifier)
                    .pickAndProcessVideo();
              },
              child: const Text('読み込みたい動画を選択'),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('エラー: $error'),
        ),
      ),
    );
  }
}
