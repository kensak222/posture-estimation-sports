import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import 'domain/pose-estimation-network/posture_estimation_service.dart';
import 'infra/pose-estimation-network/posture_estimation_repository.dart';

final dioProvider = Provider((ref) => Dio());

final repositoryProvider = Provider(
  (ref) => PostureEstimationRepository(ref.read(dioProvider)),
);

final serviceProvider = Provider(
  (ref) => PostureEstimationService(ref.read(repositoryProvider)),
);
