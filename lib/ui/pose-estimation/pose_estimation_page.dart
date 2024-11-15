import 'dart:io';
import 'dart:typed_data' as type;

import 'package:flutter/material.dart';
import 'package:posture_estimation_sports/domain/pose-estimation/pose_estimator.dart';
import 'package:image/image.dart' as img;

import '../../domain/person-detect/person_detector.dart';
import '../../util/utils.dart';

class PoseEstimationPage extends StatefulWidget {
  final List<File> frames;

  const PoseEstimationPage({super.key, required this.frames});

  @override
  State<PoseEstimationPage> createState() => _PoseEstimationPageState();
}

class _PoseEstimationPageState extends State<PoseEstimationPage> {
  final List<img.Image> _estimatedImages = List.empty(growable: true);
  late PoseEstimator _poseEstimator;
  late PersonDetector _personDetector;

  @override
  void initState() {
    dPrint('_PoseEstimationPageState#initState が呼ばれました');
    super.initState();
    _poseEstimator = PoseEstimator();
    _personDetector = PersonDetector();
  }

  @override
  Widget build(BuildContext context) {
    dPrint('_PoseEstimationPageState#build が呼ばれました');
    dPrint('frames size = ${widget.frames.length}');
    dPrint('frames = ${widget.frames}');

    if (widget.frames.length != _estimatedImages.length) {
      widget.frames.indexedMap((int i, File frame) async {
        if (_poseEstimator.isInterpreterNull()) {
          debugPrint('_poseEstimatorの_interpreterがnullなので初期化します');
          await _poseEstimator.loadModel();
        }
        if (_personDetector.isInterpreterNull()) {
          debugPrint('_personDetectorの_interpreterがnullなので初期化します');
          await _personDetector.loadModel();
        }
        debugPrint('$i回目の推論を行います');
        final image = img.decodeImage(frame.readAsBytesSync())!;
        // YOLOで物体検出
        final detectedObjects = await _personDetector.detectObjects(image);

        // 検出結果に基づいてROIクロッピング
        final detectedObject = detectedObjects[0];
        final croppedImage = _personDetector.cropImageByBoundingBox(
          image,
          detectedObject.boundingBox,
        );
        _estimatedImages.add(
          img.copyResize(croppedImage, width: 180, height: 240),
        );

        // // MoveNetで姿勢推定
        // final pose = await _poseEstimator.estimatePose(croppedImage);
        //
        // // 姿勢推定結果を画像に描画（関節や接続線）
        // final resultImage = await _poseEstimator.drawPoseOnImage(
        //     croppedImage, pose
        // );
        // _estimatedImages.add(resultImage);

        // detectedObjects.indexedMap((int i, DetectedObject detectedObject) async {
        //   // final croppedImage = detectedObject.cropImage(image);
        //   final croppedImage = _personDetector.cropImageByBoundingBox(
        //       image, detectedObject.boundingBox,
        //   );
        //
        //   // MoveNetで姿勢推定
        //   final pose = await _poseEstimator.estimatePose(croppedImage);
        //
        //   // 姿勢推定結果を画像に描画（関節や接続線）
        //   final resultImage = await _poseEstimator.drawPoseOnImage(
        //       croppedImage, pose
        //   );
        //   _estimatedImages.add(resultImage);
        // });

        if (_estimatedImages.isNotEmpty) {
          dPrint('_estimatedImages : $_estimatedImages');
          setState(() {
            _estimatedImages;
          });
        } else {
          dPrint('_estimatedImages が空です');
        }
      });
    } else {
      _poseEstimator.close();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('姿勢推定結果')),
      body: (_estimatedImages.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _estimatedImages.length,
              itemBuilder: (context, index) {
                return Image.memory(type.Uint8List.fromList(
                  img.encodePng(_estimatedImages[index]),
                ));
              },
            ),
    );
  }
}
