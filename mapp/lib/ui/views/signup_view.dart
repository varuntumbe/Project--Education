import 'package:mapp/core/enums.dart';
import 'package:mapp/ui/shared/text_styles.dart';
import 'package:mapp/ui/shared/ui_helpers.dart';
import 'package:mapp/ui/views/base_view.dart';
import 'package:mapp/ui/widgets/appbar_drawer.dart';
import 'package:mapp/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:mapp/core/viewmodel/signupview_model.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: myAppBar('mapp'),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey2,
            child: ListView(
              children: [
                UIHelper.verticalSpace(150),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Sign Up',
                    style: signInSingUpTextStyle,
                  ),
                ),
                UIHelper.verticalSpaceMedium(),
                InputField(
                  controller: nameController,
                  hintText: 'Name',
                  validate: (value) {
                    if (value.isEmpty) {
                      return "Name cant be Empty";
                    }
                    return null;
                  },
                ),
                UIHelper.verticalSpace(10),
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
                    }),
                UIHelper.verticalSpaceSmall(),
                Container(
                  padding: EdgeInsets.only(left: 120, right: 120),
                  child: model.state == ViewState.Idle
                      ? ElevatedButton(
                          child: Text('submit'),
                          onPressed: () async {
                            if (_formKey2.currentState.validate()) {
                              var result = await model.signUp(
                                  name: nameController.text,
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
                              strokeWidth: 5.0,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
