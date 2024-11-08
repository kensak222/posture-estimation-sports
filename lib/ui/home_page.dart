import 'package:flutter/material.dart';
import 'package:posture_estimation_sports/router.dart';
import 'package:posture_estimation_sports/util/Utils.dart';
import 'package:posture_estimation_sports/ui/video_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    Utils.debugPrint('_HomePageState#initState が呼ばれました');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils.debugPrint('_HomePageState#build が呼ばれました');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: OutlinedButton(
            onPressed: () async {
              Utils.debugPrint('読み込みたい動画を選択 ボタンがタップされました');
              // イメージライブラリから動画を選択する
              final videoPicker = VideoPicker();
              final video = await videoPicker.pickVideo();
              if (video != null) {
                // 動画を選択した後の処理
                final frames = await videoPicker.extractFrames(video);
                if (!context.mounted) {
                  Utils.debugPrint('context がマウントされていません');
                  return;
                }
                PoseEstimationRoute($extra: frames).go(context);
              }
            },
            child: const Text('読み込みたい動画を選択')
        ),
      ),
    );
  }
}