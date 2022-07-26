import 'dart:convert';
import 'dart:io';
import 'package:mapp/core/enums.dart';
import 'package:http/http.dart' as http;
import 'package:mapp/core/models/failureObj.dart';
import 'package:mapp/core/models/googleFormobj.dart';
import 'package:mapp/core/services/authentication_service.dart';
import 'package:mapp/locator.dart';
import 'base_model.dart';
import 'package:flutter/services.dart';

class ViewGoogleFormsModel extends BaseModel {
  String viewGoogleFormEndpoint =
      '1fc8-2405-204-5682-22da-45a7-70f0-91c-fe94.in.ngrok.io';
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
          formName: 'class test for 10th',
          formCreatedAt: '12-02-2020'),
      GoogleFormObj(
          formLink:
              'https://docs.google.com/forms/d/1oljpAbDPLOQrKBl3gksLNp2Lbb4ayVJpdPhwyfNerBY/edit',
          formName: 'class test for 2',
          formCreatedAt: '12-02-2020'),
    ];

    // List<GoogleFormObj> googleforms =
    //     await Future.delayed(Duration(seconds: 5), () => allGoogleForms);
    // this.allGoogleFormsCreatedByuser = googleforms;
    this.error_message = 'internet Failure';
    setState(ViewState.Error);
  }

  void fetchAllGoogleForms() async {
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

    try {
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
        throw Failure('Failed to fetch google forms infos');
      }
      setState(ViewState.Idle);
    } on SocketException catch (_) {
      print(_);

      this.error_message = 'No Internet connection 😑';
      setState(ViewState.Error);
    } on HttpException catch (_) {
      print(_);
      this.error_message = 'Something went wrong in fetching question';
      setState(ViewState.Error);
    } catch (_) {
      print(_);
      this.error_message = 'unhandled Exception';
      setState(ViewState.Error);
    }
  }

  void copyToClipBoard(formLink) {
    Clipboard.setData(ClipboardData(text: formLink));
  }
}
