import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapp/core/viewmodel/viewgoogleform_model.dart';
import 'package:mapp/ui/views/base_view.dart';
import 'package:mapp/ui/widgets/appbar_drawer.dart';
import 'package:mapp/core/enums.dart';
import 'package:mapp/ui/shared/shared_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewGoogleForms extends StatefulWidget {
  const ViewGoogleForms({Key key}) : super(key: key);

  @override
  State<ViewGoogleForms> createState() => _ViewGoogleFormsState();
}

class _ViewGoogleFormsState extends State<ViewGoogleForms> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ViewGoogleFormsModel>(
      onModelReady: (model) {
        //model.fetchAllGoogleForms();
        //currently calling mocking endpoint
        model.mockfetchAllGoogleForms();
      },
      builder: (context, model, child) => ResponsiveSizer(
        builder: (
          context,
          orientation,
          screenType,
        ) =>
            Scaffold(
          appBar: myAppBar('View All Google Form'),
          body: model.state == ViewState.Busy
              ? Container(
                  child: CircularProgressIndicator(),
                  alignment: Alignment.center,
                )
              : ListView.builder(
                  itemCount: model.allGoogleFormsCreatedByuser.length,
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
                        print('pressed');
                        print(model.allGoogleFormsCreatedByuser[0].formName);
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          //padding: EdgeInsets.all(35),
                          padding: EdgeInsets.symmetric(
                              vertical: 4.355.h, horizontal: 8.912.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'googleFormResponseView',
                                        arguments: model
                                            .allGoogleFormsCreatedByuser[index]
                                            .formLink
                                            .toString());
                                  },
                                  child: Text('Form Name : ' +
                                      model.allGoogleFormsCreatedByuser[index]
                                          .formName +
                                      '\n\n' +
                                      'created on : ' +
                                      model.allGoogleFormsCreatedByuser[index]
                                          .formCreatedAt
                                          .toString()),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    //padding: const EdgeInsets.all(10.0),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.244.h, horizontal: 2.546.w),
                                    child: ElevatedButton(
                                        style: elevatedButtonStyle,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, 'googleFormResponseView',
                                              arguments: model
                                                  .allGoogleFormsCreatedByuser[
                                                      index]
                                                  .formLink
                                                  .toString());
                                        },
                                        child: Text('open form')),
                                  ),
                                  Padding(
                                    //padding: const EdgeInsets.all(10.0),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.244.h, horizontal: 2.546.w),
                                    child: ElevatedButton(
                                        style: elevatedButtonStyle,
                                        onPressed: () {
                                          model.copyToClipBoard(model
                                              .allGoogleFormsCreatedByuser[
                                                  index]
                                              .formLink);
                                        },
                                        child: Text('copy Link')),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
