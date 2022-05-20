import 'package:mapp/core/enums.dart';
import 'package:mapp/core/models/questions.dart';
import 'package:mapp/core/services/ocrTextExtraction_service.dart';
import 'package:mapp/core/services/questionGeneration_service.dart';
import '../models/fileobj.dart';
import 'package:mapp/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'base_model.dart';
import 'dart:io';
import '../services/textExtractionFromPdf_service.dart';
import '../services/parallelProcessing_service.dart';
import 'package:image_picker/image_picker.dart';

class HomeViewModel extends BaseModel {
  List<FileObj> selectedFilesList;
  final OcrImplService _ocrImplService = locator<OcrImplService>();

  HomeViewModel() {
    selectedFilesList = List<FileObj>.empty(growable: true);
  }

  Future captureImageFromCamera() async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 90);
    print(imageFile);
    if (imageFile != null) {
      selectedFilesList.add(FileObj.fromFile(file: imageFile));
      setState(ViewState.Idle);
    }
  }

  Future selectImages() async {
    List<File> pickedFilesList = List<File>.empty(growable: true);

    FilePickerResult pickedFiles = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.custom,
            //allowedExtensions: ['jfif', 'jpeg'],
            allowedExtensions: ['jfif', 'jpeg', 'pdf']);
    if (pickedFiles != null) {
      pickedFilesList = pickedFiles.paths.map((path) => File(path)).toList();
    } else {
      // User canceled the picker
      print('user cancelled picker');
    }

    List<FileObj> resultsobjs = [];
    resultsobjs =
        pickedFilesList.map((e) => FileObj.fromFile(file: e)).toList();

    resultsobjs.forEach((element) {
      //TODO: this checking is not working build an efficient way to check that
      if (!selectedFilesList.contains(element)) selectedFilesList.add(element);
      print(element);
    });

    //now that we have populated the list we call notifylistener to updated the UI
    setState(ViewState.Idle);
  }

  void delFobjsFromFilesSelected(int index) {
    selectedFilesList.removeAt(index);
    setState(ViewState.Idle);
  }

  Future<String> useOcrAndPdfParserToGetText() async {
    setState(ViewState.Busy);

    List<FileObj> imageFilesList = [];
    List<String> pdfFilesList = [];

    for (FileObj file in selectedFilesList) {
      if (file.isPdf)
        pdfFilesList.add(file.filepath);
      else
        imageFilesList.add(file);
    }

    //sending images selected to ocrTextExctraction Service to get text
    String extractedTextFromImages =
        await _ocrImplService.extractTextFromImages(imageobjs: imageFilesList);

    //sending pdfs selected to PdfParserExtraction Service to get text
    String extractedTextFromPdfs =
        await ParallelProcessService.initAndRunComputeFunctions(
            getTextFromPdfV4, pdfFilesList);

    print('result from parallel processing');
    print(extractedTextFromPdfs);

    setState(ViewState.Idle);
    return extractedTextFromImages + extractedTextFromPdfs;
  }
}
