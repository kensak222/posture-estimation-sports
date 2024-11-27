import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';
import '../../util/utils.dart';

class VideoPlayerScreen extends HookWidget {
  final String videoPath;

  const VideoPlayerScreen({required this.videoPath, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d("動画再生を開始します videoPath : $videoPath");

    final controller = useMemoized(
        () => VideoPlayerController.networkUrl(Uri.parse(videoPath)));
    final initialized = useState(false);
    final isPlaying = useState(false);

    useEffect(() {
      controller.initialize().then((_) {
        initialized.value = true;
        // 初期化完了後に自動で再生
        controller.play();
      });
      controller.addListener(() {
        // 再生状態の変更を監視する
        if (controller.value.isPlaying != isPlaying.value) {
          isPlaying.value = controller.value.isPlaying;
        }
      });
      return controller.dispose;
    }, [controller]);

    if (!initialized.value) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
        // 再生していない場合に再生ボタンを表示
        if (!isPlaying.value)
          Center(
            child: IconButton(
              icon: const Icon(
                Icons.play_arrow,
                size: 64,
                color: Colors.black,
              ),
              onPressed: () {
                logger.d('再生ボタンがタップされました');
                controller.play();
                isPlaying.value = true;
              },
            ),
          ),
      ],
    );
  }
}
