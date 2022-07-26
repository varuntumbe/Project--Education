import 'package:mapp/ui/shared/shared_styles.dart';
import 'package:mapp/ui/widgets/appbar_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../core/viewmodel/homeview_model.dart';
import 'base_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key key}) : super(key: key);

  final _formkey3 = GlobalKey<FormState>();
  final couponCompanyNameController = TextEditingController();
  final couponCodeController = TextEditingController();
  PanelController panelController = PanelController();
  //HomeViewModel homeViewModel = locator<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    print('home');
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    print('height : ' + height.toString());
    print('width : ' + width.toString());
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => ResponsiveSizer(
        builder: (
          context,
          orientation,
          screenType,
        ) =>
            Scaffold(
          appBar: myAppBar('AQG'),
          drawer: myAppDrawer(context),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  // margin: EdgeInsets.all(30),
                  // padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(
                      vertical: 3.733.h, horizontal: 7.63.w),
                  padding: EdgeInsets.symmetric(
                      vertical: 2.48.h, horizontal: 5.092.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue,
                        width: 1.018.w,
                        style: BorderStyle.solid), //Border.all

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) => Container(
                      // padding: EdgeInsets.all(3),
                      // margin: EdgeInsets.all(1),
                      padding: EdgeInsets.symmetric(
                          vertical: 0.373.h, horizontal: 0.763.w),
                      margin: EdgeInsets.symmetric(
                          horizontal: 0.254.w, vertical: 0.1244.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blueAccent)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: model.selectedFilesList[index].isPdf
                                ? Center(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(25),
                                      child: FittedBox(
                                        child: Icon(
                                          Icons.picture_as_pdf_rounded,
                                          //       size: 50,
                                        ),
                                      ),
                                    ),
                                  )
                                : Image.file(
                                    model.selectedFilesList[index].toFile(),
                                  ),
                          ),
                          GestureDetector(
                              child: Icon(Icons.close),
                              onTap: () {
                                model.delFobjsFromFilesSelected(index);
                              }),
                        ],
                      ),
                    ),
                    itemCount: model.selectedFilesList.length,
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                child: Container(
                  // padding: EdgeInsets.fromLTRB(50, 50, 50, 20),
                  padding:
                      EdgeInsets.fromLTRB(12.731.w, 6.221.h, 12.731.w, 2.488.h),
                  child: Container(
                    //padding: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(
                        vertical: 1.244.h, horizontal: 2.546.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                      color: Colors.blueAccent,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: Container(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(30),
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.camera,
                                      //size: 60.0,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                model.captureImageFromCamera();
                              },
                            ),
                            GestureDetector(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(30),
                                child: FittedBox(
                                  child: Icon(
                                    Icons.folder,
                                    //size: 60.0,
                                  ),
                                ),
                              ),
                              onTap: () {
                                model.selectImages();
                              },
                            )
                          ],
                        ),
                        Container(
                          //padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          padding: EdgeInsets.fromLTRB(
                              2.546.w, 2.488.h, 2.546.w, 1.244.h),
                          child: ElevatedButton(
                            style: elevatedButtonStyle,
                            onPressed: () async {
                              String extractedText =
                                  await model.useOcrAndPdfParserToGetText();

                              //Here the above function extracts text from pictures

                              Navigator.pushNamed(context, 'questionspage',
                                  arguments: extractedText);
                            },
                            child: Text(
                              'Get Questions',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    //color: Colors.blueAccent,
                    border: Border(
                      top: BorderSide(
                          color: Colors.blue[900],
                          style: BorderStyle.solid,
                          width: 2.546.w),
                    ),
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
