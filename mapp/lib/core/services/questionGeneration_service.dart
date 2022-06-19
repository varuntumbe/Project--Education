//This is a Fake Service class which has to be implemented

import 'package:mapp/core/enums.dart';
import 'package:meta/meta.dart';
import 'package:mapp/core/models/questions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionGenerationService {
  String serverUrl =
      'https://25d8-2409-4071-d1b-2153-7464-e63-fe5d-be65.in.ngrok.io/send';

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

  Future<List<QuestionObj>> generateQuestions2(
      {@required extractedText}) async {
    print('extracted Text we are sending');
    print(extractedText);
    List<QuestionObj> result = [];
    result = await this.fetchQuestionsByPostReq(extractedText);
    return result;
  }

  Future<List<QuestionObj>> fetchQuestionsByPostReq(
      String extractedText) async {
    List<QuestionObj> fetchedQuestions = [];
    List<String> payLoadData = [];
    payLoadData.add(extractedText);
    final response = await http.post(
      Uri.parse(this.serverUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
      body: jsonEncode(payLoadData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.body);

      String resbody = response.body;

      print('response we got');
      print(resbody);

      List<dynamic> resultRes = jsonDecode(resbody);
      List<String> resultQuestions = new List.from(resultRes);

      resultQuestions.forEach((question) {
        fetchedQuestions.add(QuestionObj.fromString(question));
      });

      return fetchedQuestions;
    } else {
      print('error');
      print(response);
      throw Exception('error in fetching questions');
    }
  }
}
