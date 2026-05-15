import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';
import 'package:mindtrip/core/widget/appp_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class AttachmentPickerService {
  AttachmentPickerService._();

  //  Limits
  static const int maxPhotos = 6;
  static const int maxPhotoBytes = 10 * 1024 * 1024; // 10 MB
  static const int maxVideoBytes = 100 * 1024 * 1024; // 100 MB
  static const int maxFiles = 2;
  static const int maxFileBytes = 25 * 1024 * 1024; // 25 MB

  static final _picker = ImagePicker();

  //  camera or gallery
  static Future<List<XFile>> pickPhotos(
    BuildContext context, {
    required ImageSource source,
  }) async {
    final granted = await _requestPermission(
      context,
      source == ImageSource.camera ? Permission.camera : Permission.photos,
      denied: 'Camera permission is required to take photos.',
    );
    if (!granted) return [];

    List<XFile> picked = [];

    if (source == ImageSource.camera) {
      final file = await _picker.pickImage(source: ImageSource.camera);
      if (file != null) picked = [file];
    } else {
      picked = await _picker.pickMultiImage(limit: maxPhotos);
    }
    if (!context.mounted) {
      return [];
    }
    return _filterBySize(
      context,
      files: picked,
      maxBytes: maxPhotoBytes,
      maxCount: maxPhotos,
      typeName: 'photo',
      sizeLimitLabel: '10 MB',
    );
  }

  //  Video

  static Future<XFile?> pickVideo(BuildContext context) async {
    final granted = await _requestPermission(
      context,
      Permission.photos,
      denied: 'Photo library permission is required to pick a video.',
    );
    if (!granted) return null;

    final file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file == null) return null;

    final bytes = await File(file.path).length();
    if (bytes > maxVideoBytes) {
      if (context.mounted) {
        AppSnackBar.showError(
          context,
          message: 'Video exceeds 100 MB limit and was not sent.',
        );
      }
      return null;
    }
    return file;
  }

  //  Files

  static Future<List<PlatformFile>> pickFiles(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: false,
    );
    if (result == null) return [];

    final capped = result.files.take(maxFiles).toList();
    if (result.files.length > maxFiles && context.mounted) {
      AppSnackBar.showError(
        context,
        message:
            'Maximum $maxFiles files allowed. Only the first $maxFiles were selected.',
      );
    }

    final valid = <PlatformFile>[];
    for (final f in capped) {
      final size = f.size;
      if (size > maxFileBytes) {
        if (context.mounted) {
          AppSnackBar.showError(
            context,
            message: '"${f.name}" exceeds 25 MB and was not attached.',
          );
        }
      } else {
        valid.add(f);
      }
    }
    return valid;
  }

  //  Helpers

  static Future<List<XFile>> _filterBySize(
    BuildContext context, {
    required List<XFile> files,
    required int maxBytes,
    required int maxCount,
    required String typeName,
    required String sizeLimitLabel,
  }) async {
    // Enforce count cap
    List<XFile> capped = files;
    if (files.length > maxCount) {
      capped = files.take(maxCount).toList();
      if (context.mounted) {
        AppSnackBar.showError(
          context,
          message:
              'Maximum $maxCount ${typeName}s allowed. Extras were removed.',
        );
      }
    }

    // Enforce per-file size
    final valid = <XFile>[];
    for (final f in capped) {
      final bytes = await File(f.path).length();
      if (bytes > maxBytes) {
        if (context.mounted) {
          AppSnackBar.showError(
            context,
            message:
                '"${f.name}" exceeds $sizeLimitLabel and was not attached.',
          );
        }
      } else {
        valid.add(f);
      }
    }
    return valid;
  }

  static Future<bool> _requestPermission(
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
      AppSnackBar.showError(context, message: denied);
    }
    return false;
  }
}
