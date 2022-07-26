import 'package:mapp/core/models/user.dart';
import 'package:mapp/core/services/authentication_service.dart';
import 'package:mapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

//creating a class for AppBar
Widget myAppBar(title) => AppBar(
      centerTitle: true,
      title: Text(title),
    );

//creating a AppWide One Drawer
Widget myAppDrawer(context) {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  User currentUser = _authenticationService.currentUser;
  return ResponsiveSizer(
    builder: (contexte, orientation, screenType) => Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Container(
              //padding: EdgeInsets.all(5),
              padding:
                  EdgeInsets.symmetric(vertical: 0.622.h, horizontal: 1.66.w),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              alignment: Alignment(0.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(12),
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        //size: 30.0,
                      ),
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
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'allGoogleFormsCreatedByuser');
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(vertical: 0.622.h, horizontal: 1.66.w),
              height: 6.2217.h,
              decoration: BoxDecoration(
                  color: Colors.blueAccent[100],
                  borderRadius: BorderRadius.circular(25)),
              alignment: Alignment.center,
              child: Center(
                child: Text('Get All Google Forms'),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
