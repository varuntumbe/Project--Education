import 'dart:async';
import 'package:flutter/foundation.dart';

//All Functions and data are static
class ParallelProcessService {
  static int maxnumberOfIsolate = 5000;

  //given the amount of data and maximum no of isolates it divides the data per isolate
  static List<List<String>> determineDataPerIsolate(
      List<dynamic> dataToBeProcessed) {
    List<List<String>> dataPerisolate = [];
    List<String> data = [];
    data = dataToBeProcessed;
    int dataPerIsolate =
        (data.length / ParallelProcessService.maxnumberOfIsolate).ceil();

    int counter = 0;
    while (counter < data.length) {
      List<String> temp = [];
      for (int icounter = counter;
          icounter < counter + dataPerIsolate && icounter < data.length;
          icounter += 1) {
        temp.add(data[icounter]);
      }
      dataPerisolate.add(temp);

      counter += dataPerIsolate;
    }
    return dataPerisolate;
  }

  static String convertListOfStringsToSingleString(List<String> results) {
    String resultString = '';
    for (String result in results) {
      resultString += result + '\n';
    }

    return resultString;
  }

//this function will run compute function
  static Future<String> initAndRunComputeFunctions(
      Future<String> Function(String param) computationFunction,
      List<dynamic> dataToBeProcessed) async {
    List<Future<String>> computedResult = [];
    List<List<String>> dataPerisolate =
        ParallelProcessService.determineDataPerIsolate(dataToBeProcessed);

    int counter = 0;
    for (List<String> data in dataPerisolate) {
      computedResult.add(compute(computationFunction, data[0],
          debugLabel: counter.toString()));
      counter += 1;
    }

    List<String> results = await Future.wait(computedResult);
    print('result : ');
    print(results);
    return ParallelProcessService.convertListOfStringsToSingleString(results);
  }
}
