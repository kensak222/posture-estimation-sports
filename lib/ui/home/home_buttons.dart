import 'package:flutter/material.dart';
import 'package:posture_estimation_sports/util/utils.dart';

class HomeButtons extends StatelessWidget {
  final VoidCallback onDeviceEstimationPressed;
  final VoidCallback onServerEstimationPressed;

  const HomeButtons({
    Key? key,
    required this.onDeviceEstimationPressed,
    required this.onServerEstimationPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: onDeviceEstimationPressed,
          child: const Text('端末上で姿勢推定'),
        ),
        OutlinedButton(
          onPressed: onServerEstimationPressed,
          child: const Text('サーバ上で姿勢推定'),
        ),
      ].withSpaceBetween(height: 20),
    );
  }
}
