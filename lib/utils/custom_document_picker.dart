import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomDocumentPicker {
  static Future<File?> openDocument(
      BuildContext context, {
        List<String>? params,
      }) async {
    try {
      FilePickerResult? file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: params,
        withData: false,
        withReadStream: false,
      );

      if (file == null || file.files.isEmpty) return null;

      final path = file.files.single.path;
      if (path == null) return null;

      return File(path);
    } catch (_) {
      return null;
    }
  }

  static Future<List<File>?> openMultiDocument(
      BuildContext context, {
        List<String>? params,
      }) async {
    try {
      FilePickerResult? files = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: params,
        allowMultiple: true,
        withData: false,
        withReadStream: false,
      );

      if (files == null) return null;

      return files.files
          .where((e) => e.path != null)
          .map((e) => File(e.path!))
          .toList();
    } catch (_) {
      return null;
    }
  }
}