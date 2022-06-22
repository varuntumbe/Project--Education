import 'dart:convert';
import 'package:mapp/core/enums.dart';
import 'package:http/http.dart' as http;
import 'package:mapp/core/models/googleFormobj.dart';
import 'package:mapp/core/services/authentication_service.dart';
import 'package:mapp/locator.dart';
import 'base_model.dart';
import 'package:flutter/services.dart';

class ViewGoogleFormsModel extends BaseModel {
  String viewGoogleFormEndpoint = '455d-36-255-86-139.in.ngrok.io';
  List<GoogleFormObj> allGoogleFormsCreatedByuser = [];
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void mockfetchAllGoogleForms() async {
    //mocking the endpoint
    setState(ViewState.Busy);
    List<GoogleFormObj> allGoogleForms = [
      GoogleFormObj(
          formLink:
              'https://docs.google.com/forms/d/1ztLCam_9XLgJW6c65Uqam1Ld3QiMsSQdQ8uTeWngFks/edit',
          formName: 'class test for 10th'),
      GoogleFormObj(
          formLink:
              'https://docs.google.com/forms/d/1oljpAbDPLOQrKBl3gksLNp2Lbb4ayVJpdPhwyfNerBY/edit',
          formName: 'class test for 2'),
    ];

    List<GoogleFormObj> googleforms =
        await Future.delayed(Duration(seconds: 5), () => allGoogleForms);
    this.allGoogleFormsCreatedByuser = googleforms;
    setState(ViewState.Idle);
  }

  void fetchAllGoogleForms() async {
    //mocking the endpoint
    setState(ViewState.Busy);
    Map<String, String> queryParams = {
      'email': _authenticationService.currentUser.email.toString(),
    };

    var uri = Uri(
      scheme: 'https',
      host: viewGoogleFormEndpoint,
      path: '/get_all_forms',
      queryParameters: queryParams,
    );

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive'
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body));

      List<dynamic> allformRes = jsonDecode(response.body);
      List<GoogleFormObj> allformsResGoogleObjs = [];
      allformRes.forEach((obj) {
        allformsResGoogleObjs.add(GoogleFormObj.fromJson(obj));
      });

      this.allGoogleFormsCreatedByuser = allformsResGoogleObjs;
    } else {
      throw Exception('Failed to Fetch redirection Url');
    }
    setState(ViewState.Idle);
  }

  void copyToClipBoard(formLink) {
    Clipboard.setData(ClipboardData(text: formLink));
  }
}
