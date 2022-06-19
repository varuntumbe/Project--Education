import 'dart:convert';

import 'package:mapp/core/enums.dart';
import 'package:http/http.dart' as http;
import 'package:mapp/core/models/googleFormobj.dart';
import 'base_model.dart';

class ViewGoogleFormsModel extends BaseModel {
  String viewGoogleFormEndpoint = '';

  Future<List<GoogleFormObj>> fetchAllGoogleForms() async {
    //mocking the endpoint
    List<GoogleFormObj> allGoogleForms = [
      GoogleFormObj(formLink: 'wwwaab v', formName: 'class test for 10th'),
      GoogleFormObj(formLink: 'jjjj', formName: 'class test for 2'),
    ];

    return await Future.delayed(Duration(seconds: 5), () => allGoogleForms);
  }
}
