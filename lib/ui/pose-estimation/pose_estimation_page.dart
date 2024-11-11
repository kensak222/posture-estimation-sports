import 'dart:io';
import 'dart:typed_data' as type;

import 'package:flutter/material.dart';
import 'package:posture_estimation_sports/ui/pose-estimation/pose_estimator.dart';
import 'package:image/image.dart' as img;

import '../../util/Utils.dart';

class PoseEstimationPage extends StatefulWidget {
  final List<File> frames;

  const PoseEstimationPage({super.key, required this.frames});

  @override
  State<PoseEstimationPage> createState() => _PoseEstimationPageState();
}

class _PoseEstimationPageState extends State<PoseEstimationPage> {

  final List<img.Image> _estimatedImages = List.empty(growable: true);
  late PoseEstimator _poseEstimator;

  @override
  void initState() {
    Utils.debugPrint('_PoseEstimationPageState#initState が呼ばれました');
    super.initState();
    _poseEstimator = PoseEstimator();
  }

  @override
  Widget build(BuildContext context) {
    Utils.debugPrint('_PoseEstimationPageState#build が呼ばれました');
    Utils.debugPrint('frames size = ${widget.frames.length}');
    Utils.debugPrint('frames = ${widget.frames}');

    if (widget.frames.length != _estimatedImages.length) {
      widget.frames.forEach((frame) async {
        if (_poseEstimator.isInterpreterNull()) {
          Utils.debugPrint('_interpreter がnullなので初期化します');
          await _poseEstimator.loadModel();
        }
        Utils.debugPrint('姿勢推定を実行します');
        final image = img.decodeImage(frame.readAsBytesSync())!;
        // 姿勢推定を実行
        final poseData = await _poseEstimator.estimatePose(image);
        final overlayImage = await _poseEstimator
            .drawPoseOnImage(image, poseData);
        setState(() {
          _estimatedImages.add(overlayImage);
        });
      });
    } else {
      _poseEstimator.close();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('姿勢推定結果')),
      body: (widget.frames.length != _estimatedImages.length)
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(itemCount: _estimatedImages.length,
        itemBuilder: (context, index) {
            return Image.memory(
                type.Uint8List.fromList(img.encodePng(_estimatedImages[index])));
            },
      ),
    );
  }
}
