import 'package:flutter/material.dart';
import 'package:mapp/core/viewmodel/viewgoogleformres_model.dart';
import 'package:mapp/ui/views/base_view.dart';
import 'package:mapp/ui/widgets/appbar_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewAllGoogleFormsWebView extends StatefulWidget {
  final String webViewUrl;
  ViewAllGoogleFormsWebView({Key key, this.webViewUrl}) : super(key: key);

  @override
  State<ViewAllGoogleFormsWebView> createState() =>
      _ViewAllGoogleFormsWebViewState();
}

class _ViewAllGoogleFormsWebViewState extends State<ViewAllGoogleFormsWebView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ViewGoogleFormResWebModel>(
      builder: (context, model, child) => Scaffold(
        appBar: myAppBar('All Google Forms'),
        body: WebView(
          initialUrl: widget.webViewUrl,
          userAgent: 'random',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            model.controller = controller;
          },
        ),
      ),
    );
  }
}
