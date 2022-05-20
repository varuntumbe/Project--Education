import 'package:flutter/cupertino.dart';
import 'package:mapp/core/enums.dart';
import 'package:mapp/core/services/authentication_service.dart';
import 'package:mapp/core/viewmodel/base_model.dart';
import 'package:mapp/locator.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future signUp(
      {@required String name,
      @required String email,
      @required String password,
      @required BuildContext context}) async {
    setState(ViewState.Busy);

    var result = await _authenticationService.signUpWithEmail(
        name: name, email: email, password: password);

    setState(ViewState.Idle);

    /*In the AuthService we send Boolean if everything goes right else 
        we send a String*/
    if (result is bool) {
      if (result) {
        Navigator.pushNamed(context, 'login');
      } else {
        print('Result is Null');
        return "Result is Null Error";
      }
    } else {
      print(result);
      return result;
    }

    return true;
  }
}
