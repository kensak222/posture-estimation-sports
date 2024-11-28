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

    // 動画コントローラーを作成（ネットワークから動画を取得）
    final controller = useMemoized(
        () => VideoPlayerController.networkUrl(Uri.parse(videoPath)));
    final initialized = useState(false);
    final isPlaying = useState(false);

    useEffect(() {
      controller.initialize().then((_) {
        initialized.value = true;
        // 初期化後に自動再生
        controller.play();
      });

      // 動画再生状態の変更を監視
      controller.addListener(() {
        if (controller.value.isPlaying != isPlaying.value) {
          isPlaying.value = controller.value.isPlaying;
        }
      });

      // ウィジェット破棄時にコントローラーを解放
      return controller.dispose;
    }, [controller]);

    // 動画が初期化されるまでロード中インジケーターを表示
    if (!initialized.value) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        // 動画プレーヤーを中央に表示
        Center(
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
        ),
        // 動画を再生していない場合にオーバーレイを追加
        if (!isPlaying.value) ...[
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.6), // 半透明の黒
            ),
          ),
          // 再生ボタンを動画の上部に配置
          Positioned(
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.play_arrow,
                  size: 64,
                  color: Colors.white,
                ),
                onPressed: () {
                  logger.d('再生ボタンがタップされました');
                  controller.play(); // 再生開始
                  isPlaying.value = true; // 再生状態を更新
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}
