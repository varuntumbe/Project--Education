import 'dart:io';
import 'package:flutter/foundation.dart';

class FileObj {
  final String filesize;
  final String filepath;
  final bool isPdf;

  FileObj.fromFile({@required File file})
      : this.filesize = file.lengthSync().toString(),
        this.filepath = file.path,
        this.isPdf = file.path.endsWith('.pdf');

  File toFile() => File(filepath);

  //getter for path
  String get getFilepath => filepath;

  //getter for filesize
  String get getFilesize => filesize;

  @override
  String toString() {
    return this.filepath + " : " + this.filesize;
  }
}
