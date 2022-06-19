import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mapp/core/enums.dart';
import 'package:mapp/core/models/questions.dart';
import 'package:mapp/core/services/questionGeneration_service.dart';
import 'package:mapp/core/viewmodel/base_model.dart';
import '../../app_constants.dart';
import 'dart:convert';
import '../../locator.dart';

class QuestionPageModel extends BaseModel {
  final QuestionGenerationService _questionGenerationservice =
      locator<QuestionGenerationService>();

  //one of the state of this screen is List of Question object
  List<QuestionObj> generatedQuestions =
      List<QuestionObj>.empty(growable: true);

  void generateQuestionsUsingNLPService(
      {@required String extractedText}) async {
    setState(ViewState.Busy);
    List<QuestionObj> generatedQuestions = await _questionGenerationservice
        .generateQuestions2(extractedText: extractedText);
    this.generatedQuestions = generatedQuestions;
    setState(ViewState.Idle);
  }

  void changeIseditingProperty(int index) {
    this.generatedQuestions[index].isEditable =
        !this.generatedQuestions[index].isEditable;
    setState(ViewState.Idle);
  }

  void updateQuestionText(int index, String changedText) {
    generatedQuestions[index].questionText = changedText;
    generatedQuestions[index].isEditable =
        !generatedQuestions[index].isEditable;
    setState(ViewState.Idle);
  }

  String exportListOfQuestions() {
    Map<String, dynamic> payLoadData = jsonDecode(payLoadStructure);
    Map<String, dynamic> mcqQuestionStructure =
        jsonDecode(multipleChoiceQuestion);
    //Map<String, dynamic> paragraphAnsStructure = jsonDecode(paragraphQuestion);

    //adding our question content to this structure
    // var index = 0;
    // print('index');
    // print(index);
    // generatedQuestions.forEach((questionObj) {
    //   // if (questionObj.questiontype == QuestionType.SimpleQuestion) {

    //   index += 1;
    //   // }
    // });

    print('generatedQuestions');
    print(generatedQuestions);
    print('paragraphStruture');
    for (var i = 0; i < generatedQuestions.length; i++) {
      Map<String, dynamic> paragraphAnsStructure =
          jsonDecode(paragraphQuestion);
      paragraphAnsStructure['createItem']['location']['index'] = i;
      paragraphAnsStructure['createItem']['item']['title'] =
          generatedQuestions[i].questionText;

      payLoadData['form_body']['requests'].add(paragraphAnsStructure);
    }

    print(jsonEncode(payLoadData));
    return jsonEncode(payLoadData);
  }
}
