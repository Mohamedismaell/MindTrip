import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';
import 'package:mindtrip/core/widget/appp_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickCropService {
  final ImagePicker _picker;
  final ImageCropper _cropper;

  ImagePickCropService({ImagePicker? picker, ImageCropper? cropper})
    : _picker = picker ?? ImagePicker(),
      _cropper = cropper ?? ImageCropper();

  /// Returns the processed [File] or null
  Future<File?> pickAndCropImage(
    BuildContext context,
    ImageSource source,
  ) async {
    final granted = await _requestPermission(
      context,
      source == ImageSource.camera ? Permission.camera : Permission.photos,
      denied: source == ImageSource.camera
          ? 'Camera permission is required to take photos.'
          : 'Gallery permission is required to pick photos.',
    );
    if (!granted) return null;

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
        '${file.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.png';

    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
      minWidth: 600,
      minHeight: 600,
      format: CompressFormat.png,
    );

    if (result == null) return file;
    return File(result.path);
  }

  Future<bool> _requestPermission(
    BuildContext context,
    Permission permission, {
    required String denied,
  }) async {
    final status = await permission.request();
    if (status.isGranted) return true;

    if (status.isPermanentlyDenied && context.mounted) {
      AppDialog.show(
        context: context,
        title: 'Permission Required',
        description: denied,
        primaryText: 'Open Settings',
        onPrimary: () async {
          await openAppSettings();
        },
        secondaryText: 'Cancel',
      );
    }

    if (context.mounted) {
      AppSnackBar.showError(context: context, message: denied);
    }
    return false;
  }
}
