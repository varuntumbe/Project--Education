import '../enums.dart';
import 'package:flutter/foundation.dart';

class QuestionObj {
  bool isEditable = false;
  String questionText;
  String questionDescription;
  List<String> questionOptions;
  QuestionType questiontype;

  //basic constructor
  QuestionObj(
      {@required this.questionText,
      this.questionDescription,
      this.questionOptions,
      @required this.questiontype});

  QuestionObj.fromJson(jsonObj) {
    this.questionText = jsonObj['question'];
    if (jsonObj['description'])
      this.questionDescription = jsonObj['description'];
    if (jsonObj['options']) this.questionOptions = jsonObj['options'];
  }

  Map<String, String> convertToJsonObj() {
    return {
      'questionType': 'FIB',
      'question': this.questionText,
      'questionDescription': this.questionDescription,
    };
  }
}
