import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mapp/core/enums.dart';
import 'package:mapp/core/models/questions.dart';
import 'package:mapp/core/services/authentication_service.dart';
import 'package:mapp/core/services/questionGeneration_service.dart';
import 'package:mapp/core/viewmodel/base_model.dart';
import '../../app_constants.dart';
import 'dart:convert';
import '../../locator.dart';

class QuestionPageModel extends BaseModel {
  final QuestionGenerationService _questionGenerationservice =
      locator<QuestionGenerationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

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

  String exportListOfQuestions(formName) {
    Map<String, dynamic> payLoadData = jsonDecode(payLoadStructure);
    payLoadData["email"] = _authenticationService.currentUser.email.toString();
    payLoadData["info"]["title"] = formName;
    payLoadData["info"]["documentTitle"] = formName;

    for (var i = 0; i < generatedQuestions.length; i++) {
      Map<String, dynamic> paragraphAnsStructure =
          jsonDecode(paragraphQuestion);
      paragraphAnsStructure['createItem']['location']['index'] = i;
      paragraphAnsStructure['createItem']['item']['title'] =
          generatedQuestions[i].questionText;

      //setting answers
      for (var j = 0; j < generatedQuestions[i].answers.length; j++) {
        print(generatedQuestions[i].answers[j]);
        paragraphAnsStructure['createItem']['item']['questionItem']['question']
                ['grading']['correctAnswers']['answers']
            .add({'value': generatedQuestions[i].answers[j]});
      }

      payLoadData['form_body']['requests'].add(paragraphAnsStructure);
    }

    print(jsonEncode(payLoadData));
    return jsonEncode(payLoadData);
  }
}
