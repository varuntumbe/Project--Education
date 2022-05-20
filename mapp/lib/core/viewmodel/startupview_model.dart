import 'package:mapp/core/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mapp/core/services/authentication_service.dart';
import 'package:mapp/core/viewmodel/base_model.dart';
import 'package:mapp/locator.dart';

class StartUpViewModel extends BaseModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  DatabaseService _databaseService = locator<DatabaseService>();

  Future initialize({@required BuildContext context}) async {
    try {
      await _databaseService.initialise();
      await _handleStartUpLogic(context: context);
    } catch (e) {
      print(e);
      Navigator.pushNamed(context, 'error');
    }
  }

  Future _handleStartUpLogic({@required BuildContext context}) async {
    var hasLoggenInUser = await _authenticationService.isUserLoggedIn();
    if (hasLoggenInUser) {
      Navigator.pushNamed(context, 'home');
    } else {
      Navigator.pushNamed(context, 'login');
    }
  }
}
