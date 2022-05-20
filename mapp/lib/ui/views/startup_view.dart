import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapp/core/viewmodel/startupview_model.dart';
import 'package:mapp/ui/views/base_view.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      onModelReady: (model) {
        model.initialize(context: context);
      },
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 100,
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
    );
  }
}
