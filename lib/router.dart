import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posture_estimation_sports/ui/home_page.dart';
import 'package:posture_estimation_sports/ui/pose-estimation/pose_estimation_page.dart';

part 'router.g.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/ui',
  // routes: $appRoutes,
  routes: $appRoutes,
);

@TypedGoRoute<HomeRoute>(
  path: '/ui',
  routes: [TypedGoRoute<PoseEstimationRoute>(path: 'ui/pose-estimation')],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

class PoseEstimationRoute extends GoRouteData {
  const PoseEstimationRoute({
    required this.$extra,
  });

  final List<File> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PoseEstimationPage(frames: $extra);
}
