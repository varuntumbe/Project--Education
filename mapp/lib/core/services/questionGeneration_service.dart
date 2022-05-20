//This is a Fake Service class which has to be implemented

import 'package:flutter/cupertino.dart';
import 'package:mapp/core/enums.dart';
import 'package:mapp/core/models/questions.dart';

class QuestionGenerationService {
  Future<List<QuestionObj>> generateQuestions({@required extractedText}) async {
    List<QuestionObj> fakeGenQuestions = [
      QuestionObj(
          questionText: 'Who is the president of India ?',
          questiontype: QuestionType.SimpleQuestion),
      QuestionObj(
          questionText: 'What is the capital of Karnataka ?',
          questiontype: QuestionType.MultiChoiceQuestion,
          questionOptions: ['Banglore', 'Mysore', 'Kolkotta', 'Bangladesh']),
      QuestionObj(
          questionText: '____ is the prime minister of India',
          questiontype: QuestionType.FillInTheBlanksQuestion),
      QuestionObj(
          questionText: 'Explain the process of tilling in agriculture',
          questiontype: QuestionType.SimpleQuestion,
          questionDescription: 'write about 10-20 lines')
    ];
    return new Future.delayed(
        const Duration(seconds: 5), () => fakeGenQuestions);
  }
}
