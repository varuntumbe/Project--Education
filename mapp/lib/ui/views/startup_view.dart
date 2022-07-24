import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapp/core/viewmodel/startupview_model.dart';
import 'package:mapp/ui/views/base_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double height, width;
    // height = MediaQuery.of(context).size.height;
    // width = MediaQuery.of(context).size.width;

    // print('height : ' + height.toString());
    // print('width : ' + width.toString());
    return BaseView<StartUpViewModel>(
      onModelReady: (model) {
        model.initialize(context: context);
      },
      builder: (context, model, child) => ResponsiveSizer(
        builder: (
          context,
          orientation,
          screenType,
        ) =>
            Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 76.38.w,
                  height: 12.443.h,
                  child: CircleAvatar(
                    child: Text('AQG'),
                  ),
                ),
                CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(Color(0xff19c7c1)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
