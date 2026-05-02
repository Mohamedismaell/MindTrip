import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickCropService {
  final ImagePicker _picker;
  final ImageCropper _cropper;

  ImagePickCropService({ImagePicker? picker, ImageCropper? cropper})
    : _picker = picker ?? ImagePicker(),
      _cropper = cropper ?? ImageCropper();

  /// Returns the processed [File] or null
  Future<File?> pickAndCropImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(
      source: source,
      maxWidth: 1200,
      maxHeight: 1200,
    );
    if (picked == null) return null;

    // Crop
    final CroppedFile? cropped = await _cropper.cropImage(
      sourcePath: picked.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 90,
      maxWidth: 800,
      maxHeight: 800,
      uiSettings: [
        //Todo: edit the design later
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          cropStyle: CropStyle.circle,
        ),
        IOSUiSettings(
          title: 'Crop Photo',
          aspectRatioLockEnabled: true,
          cropStyle: CropStyle.circle,
        ),
      ],
    );
    if (cropped == null) return null;

    print('Cropped image ${cropped.path}');
    final compressed = await _compressFile(File(cropped.path));
    print('Compressed image ${compressed}');
    return compressed;
  }

  Future<File?> _compressFile(File file) async {
    final String targetPath =
        '${file.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
      minWidth: 600,
      minHeight: 600,
      format: CompressFormat.jpeg,
    );

    if (result == null) return file;
    return File(result.path);
  }
}
