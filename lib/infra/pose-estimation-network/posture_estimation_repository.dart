import 'dart:io';
import 'package:dio/dio.dart';

import '../../util/utils.dart';

class PostureEstimationRepository {
  final Dio _dio;

  PostureEstimationRepository(this._dio);

  Future<String> uploadVideo(File videoFile) async {
    logger.i("動画アップロード開始: ${videoFile.path}");
    try {
      final response = await _dio.post(
        'http://localhost:8000/process-video/',
        data: FormData.fromMap({
          'video': await MultipartFile.fromFile(videoFile.path),
        }),
      );
      logger.i("動画アップロード完了: ${response.data}");
      return response.data['path']; // サーバーからの生成動画パス
    } catch (e) {
      logger.e("動画アップロード失敗: $e");
      throw Exception('動画アップロードに失敗しました');
    }
  }
}
