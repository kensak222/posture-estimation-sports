// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/ui',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'ui/pose-estimation',
          factory: $PoseEstimationRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'ui/pose-estimation-network',
          factory: $PostureEstimationPageRouteExtension._fromState,
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/ui',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PoseEstimationRouteExtension on PoseEstimationRoute {
  static PoseEstimationRoute _fromState(GoRouterState state) =>
      PoseEstimationRoute(
        $extra: state.extra as List<File>,
      );

  String get location => GoRouteData.$location(
        '/ui/ui/pose-estimation',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $PostureEstimationPageRouteExtension on PostureEstimationPageRoute {
  static PostureEstimationPageRoute _fromState(GoRouterState state) =>
      const PostureEstimationPageRoute();

  String get location => GoRouteData.$location(
        '/ui/ui/pose-estimation-network',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
