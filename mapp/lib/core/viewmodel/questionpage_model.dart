import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mapp/core/enums.dart';
import 'package:mapp/core/models/questions.dart';
import 'package:mapp/core/services/questionGeneration_service.dart';
import 'package:mapp/core/viewmodel/base_model.dart';

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
        .generateQuestions(extractedText: extractedText);
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
}
