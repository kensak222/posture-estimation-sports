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
