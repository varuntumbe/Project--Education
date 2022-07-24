import 'package:flutter/material.dart';
import 'package:mapp/core/enums.dart';
import 'package:mapp/core/viewmodel/questionpage_model.dart';
import 'package:mapp/ui/shared/shared_styles.dart';
import 'package:mapp/ui/views/base_view.dart';
import 'package:mapp/ui/widgets/appbar_drawer.dart';
import 'package:mapp/ui/widgets/textInputDialouge.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class QuestionspageView extends StatefulWidget {
  final String extractedText;
  const QuestionspageView({Key key, this.extractedText}) : super(key: key);

  @override
  _QuestionspageViewState createState() => _QuestionspageViewState();
}

class _QuestionspageViewState extends State<QuestionspageView> {
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_editingController.text);

    return BaseView<QuestionPageModel>(
      onModelReady: (model) => {
        model.generateQuestionsUsingNLPService(
            extractedText: widget.extractedText),
      },
      builder: (context, model, child) => ResponsiveSizer(
        builder: (
          context,
          orientation,
          screenType,
        ) =>
            Scaffold(
          appBar: myAppBar('AQG'),
          drawer: myAppDrawer(context),
          body: model.state == ViewState.Busy
              ? Container(
                  child: CircularProgressIndicator(),
                  alignment: Alignment.center,
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 7,
                      child: ListView.builder(
                          itemCount: model.generatedQuestions.length,
                          shrinkWrap: true,
                          //padding: EdgeInsets.all(20),

                          padding: EdgeInsets.symmetric(
                              vertical: 2.488.h, horizontal: 5.092.w),
                          itemBuilder: (context, index) => Container(
                                //padding: EdgeInsets.all(15),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.866.h, horizontal: 3.8194.w),
                                child: InkWell(
                                  onDoubleTap: () {
                                    _editingController.text = model
                                        .generatedQuestions[index].questionText;
                                    model.changeIseditingProperty(index);
                                  },
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      //padding: EdgeInsets.all(10),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.244.h,
                                          horizontal: 2.546.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            //padding: EdgeInsets.all(25),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3.110.h,
                                                horizontal: 6.3657.w),
                                            alignment: Alignment.center,
                                            child: model
                                                    .generatedQuestions[index]
                                                    .isEditable
                                                ? TextField(
                                                    controller:
                                                        _editingController,
                                                    onSubmitted: (String
                                                        changedQuestionText) {
                                                      print('submitted');
                                                      model.updateQuestionText(
                                                          index,
                                                          changedQuestionText);
                                                    },
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent,
                                                            width: 0.254.w),
                                                      ),
                                                    ),
                                                  )
                                                : Text(' ${index + 1})   ' +
                                                    model
                                                        .generatedQuestions[
                                                            index]
                                                        .questionText),
                                          ),
                                          model.generatedQuestions[index]
                                                      .questiontype ==
                                                  QuestionType
                                                      .MultiChoiceQuestion
                                              ? //Expanded(
                                              Container(
                                                  // padding:
                                                  //     EdgeInsets.only(left: 45),
                                                  padding: EdgeInsets.only(
                                                      left: 11.4533.w),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: model
                                                          .generatedQuestions[
                                                              index]
                                                          .questionOptions
                                                          .map((e) => Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical:
                                                                        0.2488
                                                                            .h,
                                                                    horizontal:
                                                                        0.509
                                                                            .w),
                                                                child: Text(
                                                                    '  *  ' +
                                                                        e),
                                                              ))
                                                          .toList()),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(75),
                            color: Colors.blueAccent),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.244.h, horizontal: 2.546.w),
                        //margin: EdgeInsets.only(left: 50, right: 50),
                        margin:
                            EdgeInsets.only(left: 12.731.w, right: 12.731.w),
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: elevatedButtonStyle,
                          child: Text('GForm'),
                          onPressed: () async {
                            print('pressed');
                            // Navigator.pushNamed(context, 'googleformflow',
                            //     arguments: model.exportListOfQuestions());
                            TextEditingController controller =
                                TextEditingController();
                            controller.text = 'class Test';
                            await displayTextInputDialog(context, controller,
                                model.exportListOfQuestions);
                            // Navigator.pushNamed(context, 'googleformflow',
                            //     arguments:
                            //         model.exportListOfQuestions(controller.text));
                          },
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
