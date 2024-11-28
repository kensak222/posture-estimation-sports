import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posture_estimation_sports/notifier/pose-estimation/pose_estimation_notifier.dart';
import 'package:image/image.dart' as img;

import '../../util/utils.dart';

class PoseEstimationPage extends ConsumerStatefulWidget {
  final List<File> frames;

  const PoseEstimationPage({super.key, required this.frames});

  @override
  PoseEstimationPageState createState() => PoseEstimationPageState();
}

class PoseEstimationPageState extends ConsumerState<PoseEstimationPage> {
  @override
  void initState() {
    logger.d('PoseEstimationPage#initState が呼ばれました');
    super.initState();
    // 画面遷移時に一度だけ姿勢推定を行う
    Future.microtask(() {
      ref
          .read(poseEstimationNotifierProvider.notifier)
          .estimatePose(widget.frames);
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.d('PoseEstimationPage#build が呼ばれました');

    // PoseEstimator の状態を監視
    final poseEstimationState = ref.watch(poseEstimationNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Estimation'),
      ),
      body: Center(
        child: poseEstimationState.when(
          data: (results) {
            if (results.isEmpty) {
              return const CircularProgressIndicator();
            }

            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return Image.memory(img.encodePng(results[index]));
              },
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('エラー: $error'),
        ),
      ),
    );
  }
}
