import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posture_estimation_sports/ui/pose-estimation-network/video_player_screen.dart';

import '../../notifier/pose-estimation-network/posture_notifier.dart';

class PostureEstimationPage extends HookConsumerWidget {
  const PostureEstimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postureState = ref.watch(postureNotifierProvider);
    final postureNotifier = ref.read(postureNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Posture Estimation"),
      ),
      body: Center(
        child: postureState.when(
          initial: () => ElevatedButton(
            onPressed: () => postureNotifier.pickVideo(),
            child: const Text("動画を選択"),
          ),
          videoPicked: (videoPath) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("動画が選択されました"),
              ElevatedButton(
                onPressed: () => postureNotifier.processVideo(videoPath),
                child: const Text("姿勢推定を開始"),
              ),
            ],
          ),
          processing: () => const CircularProgressIndicator(),
          processed: (processedVideoPath) =>
              VideoPlayerScreen(videoPath: processedVideoPath),
          error: (message) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("エラー: $message"),
              ElevatedButton(
                onPressed: () => postureNotifier.pickVideo(),
                child: const Text("リトライ"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
