import 'package:mapp/core/services/database_sqflite_service.dart';
import 'package:sqflite/sqflite.dart';

class CacheService {
  DatabaseHelper dbInstance;
  CacheService() {
    dbInstance = DatabaseHelper.instance;
  }

  Future<String> checkWhetherCached(String imgPath) async {
    List<Map<String, dynamic>> result =
        await dbInstance.getExtractedText(imgPath);

    if (result.length == 0) {
      return "NONE";
    }

    print('cachedddddddddd');
    print(result);
    print('\n\n');
    return result[0]['etext'];
  }

  void cachingByWritingToDb(String imgPath, String etext, dynamic batch) {
    Map<String, dynamic> rowToBeWritten = {};
    rowToBeWritten['path'] = imgPath;
    rowToBeWritten['etext'] = etext;
    rowToBeWritten['frequency'] = 0;
    dbInstance.batchInsert(rowToBeWritten, batch);
  }

  Future<dynamic> getDbBatch() async {
    return await dbInstance.getBatch();
  }

  void dbBatchCommit(batch) async {
    List<dynamic> ids = await dbInstance.batchCommit(batch);
    print('results from batch commit ..');
    print(ids);
  }
}
