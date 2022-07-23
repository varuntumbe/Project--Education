import 'package:mapp/core/enums.dart';
import 'package:mapp/ui/shared/text_styles.dart';
import 'package:mapp/ui/shared/ui_helpers.dart';
import 'package:mapp/ui/views/base_view.dart';
import 'package:mapp/ui/widgets/appbar_drawer.dart';
import 'package:mapp/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:mapp/core/viewmodel/signupview_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    print('height : ' + height.toString());
    print('width : ' + width.toString());
    return BaseView<SignUpViewModel>(
      builder: (context, model, child) => ResponsiveSizer(
        builder: (
          context,
          orientation,
          screenType,
        ) =>
            Scaffold(
          appBar: myAppBar('mapp'),
          body: Container(
            padding:
                EdgeInsets.symmetric(vertical: 1.24.h, horizontal: 02.54.w),
            child: Form(
              key: _formKey2,
              child: ListView(
                children: [
                  //UIHelper.verticalSpace(150),
                  UIHelper.verticalSpace(18.665.h),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Sign Up',
                      style: signInSingUpTextStyle,
                    ),
                  ),
                  UIHelper.verticalSpace(2.48.h),
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
                  UIHelper.verticalSpace(1.244.h),
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
                  UIHelper.verticalSpace(1.244.h),
                  InputField(
                      controller: passwordController,
                      hintText: 'Password',
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Password cant be Empty";
                        }
                        return null;
                      }),
                  UIHelper.verticalSpace(1.244.h),
                  Container(
                    padding: EdgeInsets.only(left: 30.55.w, right: 30.55.w),
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
                            height: 2.488.h,
                            width: 5.09.w,
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
      ),
    );
  }
}
