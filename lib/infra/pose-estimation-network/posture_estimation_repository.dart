import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../util/utils.dart';

part 'posture_estimation_repository.g.dart';

@riverpod
PostureEstimationRepository postureEstimationRepository(Ref ref) {
  final dio = Dio();
  dio.interceptors.add(LogInterceptor());
  dio.options.connectTimeout = const Duration(seconds: 120);
  dio.options.receiveTimeout = const Duration(seconds: 120);
  return PostureEstimationRepository(dio);
}

class PostureEstimationRepository {
  final Dio _dio;

  PostureEstimationRepository(this._dio);

  Future<String> uploadVideo(String videoPath) async {
    try {
      final file = File(videoPath);
      final formData = FormData.fromMap({
        "video": await MultipartFile.fromFile(file.path, filename: "input.mp4"),
      });

      final response = await _dio.post(
        "http://10.0.2.2:8000/process-video/",
        data: formData,
      );

      if (response.statusCode == 200) {
        logger.d("レスポンスの取得に成功しました ${response.data.toString()}");
        return response.data["video_url"] as String;
      } else {
        final msg = "サーバーからエラーが返されました: ${response.data}";
        logger.e(msg);
        throw Exception(msg);
      }
    } on DioException catch (e) {
      logger.e(e.toString());
      throw Exception("Dioエラーが発生ました: $e");
    } catch (e) {
      logger.e(e.toString());
      throw Exception("サーバーとの通信に失敗しました: $e");
    }
  }
}
