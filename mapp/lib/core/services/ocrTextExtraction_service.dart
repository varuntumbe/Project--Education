import 'package:meta/meta.dart';
import '../models/fileobj.dart';
import 'package:simple_ocr_plugin/simple_ocr_plugin.dart';

class OcrImplService {
  //right now below method will be called for every on press of get-mcq
  //have to think of optimisation
  Future<String> extractTextFromImages(
      {@required List<FileObj> imageobjs}) async {
    if (imageobjs.length == 0) return '';
    String extractedText;
    Map<String, String> extractedTextMap = Map<String, String>();
    int imageCount = 1;
    for (dynamic imgobj in imageobjs) {
      String extractedTextFromImage =
          await this.useSimpleOcrPlugginToExtractText(imgobj);
      extractedTextMap["$imageCount"] = extractedTextFromImage;
      imageCount += 1;
    }

    extractedText = this.convertMapOfTextToString(extractedTextMap);
    return extractedText;
  }

  Future<String> useSimpleOcrPlugginToExtractText(imgfile) async {
    // FileObj fileobjImageFile = FileObj.fromFile(file: imgfile);
    String resultString;
    try {
      resultString = await SimpleOcrPlugin.performOCR(imgfile.filepath);
    } catch (e) {
      print("exception on OCR operation: ${e.toString()}");
    }
    return resultString;
  }

  String convertMapOfTextToString(Map<String, String> extractedTextMap) {
    String result = "";

    for (String key in extractedTextMap.keys) {
      result = result + extractedTextMap[key];
    }
    return result;
  }
}
