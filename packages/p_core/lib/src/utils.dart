import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<List<File?>> compressImages(List<File> files) {
  return Future.wait(_compress(files)).then((files) {
    if (!(files.every((element) => element != null))) {
      throw Exception();
    }
    return files.cast<File>();
  });
}

Iterable<Future<File?>> _compress(List<File> files, {int quality = 50}) sync* {
  for (File file in files) {
    yield compressImage(file, quality: quality);
  }
}

Future<File?> compressImage(File file, {int quality = 50}) {
  final String filePath = file.path;
  final lastIndex = filePath.lastIndexOf('.');
  final splitted = filePath.substring(0, lastIndex);
  final outPath = "${splitted}_out.jpeg";
  File outFile = File(outPath);
  return FlutterImageCompress.compressAndGetFile(
    file.path,
    outFile.path,
    quality: quality,
  );
}
