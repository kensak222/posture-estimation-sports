import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posture_estimation_sports/util/utils.dart';

class VideoPicker {

  Future<String?> pickVideo() async {
    final picker = ImagePicker();
    final video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      Utils.debugPrint('videoPath の取得に成功しました');
      return video.path;
    }
    Utils.debugPrint('videoPath の取得に失敗しました');
    return null;
  }

  Future<List<File>> extractFrames(String videoPath) async {
    // 勝手にコマ送りした画像一覧を保存してストレージを圧迫しないように、
    // 一時ディレクトリを取得してそこに姿勢推定前の画像一覧を持たせる
    final tempDir = await getTemporaryDirectory();
    final outputDir = tempDir.path;

    // FFmpegのコマンドを構築して実行
    final String outputPattern = '$outputDir/frame_%04d.png';
    final String command = '-i $videoPath -vf fps=1 $outputPattern';
    final session = await FFmpegKit.execute(command);

    // コマンド実行の結果をチェック
    final returnCode = await session.getReturnCode();
    if (returnCode?.isValueSuccess() == true) {
      Utils.debugPrint('フレーム抽出に成功しました');
      // 生成された画像ファイルをリストで取得
      final frameFiles = Directory(outputDir)
          .listSync().whereType<File>().toList();
      return frameFiles;
    } else {
      Utils.debugPrint('フレーム抽出に失敗しました');
      return List.empty();
    }
  }
}