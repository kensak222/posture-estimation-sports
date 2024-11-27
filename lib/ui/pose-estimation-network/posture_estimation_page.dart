import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../domain/bloc/pose-estimation-network/posture_bloc.dart';
import '../../domain/bloc/pose-estimation-network/posture_event.dart';
import '../../domain/bloc/pose-estimation-network/posture_state.dart';
import '../../posture_estimation_injector.dart';

class PostureEstimationPage extends HookConsumerWidget {
  const PostureEstimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = useMemoized(() => PostureBloc(
          ref.read(serviceProvider),
        ));
    final state = useState<PostureState>(PostureInitial());

    // BLoC の状態を監視して更新
    useEffect(() {
      final subscription = bloc.stream.listen((newState) {
        state.value = newState;
      });
      return subscription.cancel;
    }, [bloc]);

    return Scaffold(
      appBar: AppBar(title: const Text("姿勢推定")),
      body: Builder(
        builder: (context) {
          final currentState = state.value;

          if (currentState is PostureInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  // 動画選択処理
                  final videoFile = File('/path/to/input.mp4'); // 適切な方法で取得
                  bloc.add(ProcessVideoEvent(videoFile));
                },
                child: const Text("動画を選択"),
              ),
            );
          } else if (currentState is PostureProcessing) {
            return const Center(child: CircularProgressIndicator());
          } else if (currentState is PostureProcessed) {
            return VideoPlayerScreen(videoPath: currentState.videoPath);
          } else if (currentState is PostureError) {
            return Center(child: Text("エラー: ${currentState.message}"));
          } else {
            return const Center(child: Text("予期しない状態です"));
          }
        },
      ),
    );
  }
}

class VideoPlayerScreen extends HookWidget {
  final String videoPath;

  const VideoPlayerScreen({required this.videoPath, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
        () => VideoPlayerController.networkUrl(Uri.parse(videoPath)));
    final initialized = useState(false);

    useEffect(() {
      controller.initialize().then((_) {
        initialized.value = true;
      });
      return controller.dispose;
    }, [controller]);

    if (!initialized.value) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller),
    );
  }
}
