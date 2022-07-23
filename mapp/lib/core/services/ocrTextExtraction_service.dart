import 'package:mapp/core/services/cache_service.dart';
import 'package:mapp/locator.dart';
import 'package:meta/meta.dart';
import '../models/fileobj.dart';
import 'package:simple_ocr_plugin/simple_ocr_plugin.dart';

class OcrImplService {
  final CacheService _cacheService = locator<CacheService>();

  Future<String> extractTextFromImages(
      {@required List<FileObj> imageobjs}) async {
    if (imageobjs.length == 0) return '';
    String extractedText;
    Map<String, String> extractedTextMap = Map<String, String>();
    int imageCount = 1;

    //initializing the batches
    var batch = await _cacheService.getDbBatch();

    for (dynamic imgobj in imageobjs) {
      //looking for cached Extracted Text
      String cachedResult =
          await _cacheService.checkWhetherCached(imgobj.getFilepath);

      String extractedTextFromImage;
      if (cachedResult == "NONE") {
        extractedTextFromImage =
            await this.useSimpleOcrPlugginToExtractText(imgobj);

        //caching the text here..( but best way is to batch all the writes )
        _cacheService.cachingByWritingToDb(
            imgobj.getFilepath, extractedTextFromImage, batch);
      } else {
        print('caching is working...\n\n');
        extractedTextFromImage = cachedResult;
      }

      extractedTextMap["$imageCount"] = extractedTextFromImage;
      imageCount += 1;
    }

    //writing all the batched inserts ( preferably in separate isolate )
    _cacheService.dbBatchCommit(batch);

    extractedText = this.convertMapOfTextToString(extractedTextMap);
    print('extracted text');
    print(extractedText);
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
    print('result: ');
    print(result);
    return result;
  }
}
