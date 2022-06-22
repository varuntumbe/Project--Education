import '../enums.dart';
import 'package:flutter/foundation.dart';

class QuestionObj {
  bool isEditable = false;
  String questionText;
  String questionDescription;
  List<String> questionOptions;
  QuestionType questiontype;
  List<String> answers;

  //basic constructor
  QuestionObj(
      {@required this.questionText,
      this.questionDescription,
      this.questionOptions,
      @required this.questiontype,
      this.answers});

  QuestionObj.fromJson(jsonObj) {
    this.questionText = jsonObj['question'];
    // if (jsonObj['description'])
    //   this.questionDescription = jsonObj['description'];
    this.questiontype = QuestionType.SimpleQuestion;
    this.answers = jsonObj['answer'].split(',');
  }

  QuestionObj.fromString(questionText) {
    this.questionText = questionText;
    this.questionDescription = 'temparory description';
    this.questiontype = QuestionType.SimpleQuestion;
  }

  Map<String, String> convertToJsonObj() {
    return {
      'questionType': 'FIB',
      'question': this.questionText,
      'questionDescription': this.questionDescription,
    };
  }
}
