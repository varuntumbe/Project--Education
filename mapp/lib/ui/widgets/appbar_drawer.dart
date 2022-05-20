import 'package:mapp/core/models/user.dart';
import 'package:mapp/core/services/authentication_service.dart';
import 'package:mapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//creating a class for AppBar
Widget myAppBar(title) => AppBar(
      centerTitle: true,
      title: Text(title),
    );

//creating a AppWide One Drawer
Widget myAppDrawer() {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  User currentUser = _authenticationService.currentUser;
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            alignment: Alignment(0.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: FaIcon(
                    FontAwesomeIcons.user,
                    size: 30.0,
                  ),
                ),
                Text('Hello ${currentUser.fullName}'),
                FaIcon(
                  FontAwesomeIcons.heart,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
