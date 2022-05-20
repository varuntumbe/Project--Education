import 'package:flutter/material.dart';
import 'package:mapp/core/enums.dart';
import 'package:mapp/ui/shared/text_styles.dart';
import 'package:mapp/ui/shared/ui_helpers.dart';
import 'package:mapp/ui/views/base_view.dart';
import 'package:mapp/ui/widgets/appbar_drawer.dart';
import 'package:mapp/ui/widgets/input_field.dart';
import 'package:mapp/core/viewmodel/loginview_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<LogInViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: myAppBar('HC'),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey1,
            child: ListView(
              children: [
                UIHelper.verticalSpace(150),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Log In',
                    style: signInSingUpTextStyle,
                  ),
                ),
                UIHelper.verticalSpaceMedium(),
                InputField(
                  controller: emailController,
                  hintText: 'Email',
                  validate: (value) {
                    if (value.isEmpty) {
                      return "Email cant be Empty";
                    }
                    return null;
                  },
                ),
                UIHelper.verticalSpace(10),
                InputField(
                  controller: passwordController,
                  hintText: 'Password',
                  validate: (value) {
                    if (value.isEmpty) {
                      return "Password cant be Empty";
                    }
                    return null;
                  },
                ),
                UIHelper.verticalSpaceSmall(),
                Container(
                  padding: EdgeInsets.only(left: 120, right: 120),
                  child: model.state == ViewState.Idle
                      ? ElevatedButton(
                          child: Text('submit'),
                          onPressed: () async {
                            if (_formKey1.currentState.validate()) {
                              var result = await model.logIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context);
                              if (result != bool) {
                                model.setState(ViewState.Idle);
                              }
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
