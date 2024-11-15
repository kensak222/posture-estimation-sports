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
  bool _isFinish = false;
  late PoseEstimator _poseEstimator;
  late PersonDetector _personDetector;

  @override
  void initState() {
    logger.d('_PoseEstimationPageState#initState が呼ばれました');
    logger.d('frames size = ${widget.frames.length}');
    logger.d('frames = ${widget.frames}');
    super.initState();
    _poseEstimator = PoseEstimator();
    _personDetector = PersonDetector();
  }

  @override
  Widget build(BuildContext context) {
    logger.d('_PoseEstimationPageState#build が呼ばれました');

    if (!_isFinish) {
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
        final detectedObjects = await _personDetector.detectPersons(image);

        // 検出結果に基づいてROIクロッピング
        // final detectedObject = detectedObjects[0];
        // final croppedImage = _personDetector.cropImageByBoundingBox(
        //   image,
        //   detectedObject.boundingBox,
        // );
        // _estimatedImages.add(
        //   img.copyResize(croppedImage, width: 180, height: 240),
        // );

        final croppedImages = detectedObjects
            .map((obj) => obj.cropImageByBoundingBox(
                  image,
                  obj.boundingBox,
                ))
            .toList();
        _estimatedImages.addAll(
          croppedImages.map((croppedImage) => img.copyResize(
                croppedImage,
                width: 180,
                height: 240,
              )),
        );

        if (_estimatedImages.isNotEmpty && i == widget.frames.length - 1) {
          logger.d(
              '_estimatedImages size = ${_estimatedImages.length.toString()}');
          logger.d('_estimatedImages : $_estimatedImages');
          setState(() {
            _estimatedImages;
            _isFinish = true;
          });
        } else {
          logger.d('_estimatedImages が空です');
        }
      });
    } else {
      _poseEstimator.close();
      _personDetector.close();
    }

    if (!_isFinish) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('姿勢推定結果')),
        body: ListView.builder(
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
}
