import 'dart:convert';

import 'package:mapp/core/enums.dart';
import 'package:http/http.dart' as http;
import 'base_model.dart';

class GformWebViewFlowModel extends BaseModel {
  String webViewurl;
  String googleFormGenServiceurl =
      'https://1fc8-2405-204-5682-22da-45a7-70f0-91c-fe94.in.ngrok.io/generate_form';

  Future<String> sendPostReqAndGetRedirectedUrl(String payLoad) async {
    //return Future.delayed(Duration(seconds: 5), () => 'https://flutter.dev');
    final response = await http.post(
      Uri.parse(googleFormGenServiceurl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive'
      },
      body: payLoad,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body)['url']);

      return jsonDecode(response.body)['url'];
    } else {
      throw Exception('Failed to Fetch redirection Url');
    }
  }

  void getWebViewUrl(String payLoad) async {
    setState(ViewState.Busy);
    webViewurl = await sendPostReqAndGetRedirectedUrl(payLoad);
    setState(ViewState.Idle);
  }
}
