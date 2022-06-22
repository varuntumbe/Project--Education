import 'package:flutter/material.dart';
import 'package:mapp/core/enums.dart';
import 'package:mapp/core/viewmodel/gform_model.dart';
import 'package:mapp/ui/views/base_view.dart';
import 'package:mapp/ui/widgets/appbar_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GformWebViewFlow extends StatefulWidget {
  final String httpPayload;
  const GformWebViewFlow({Key key, this.httpPayload}) : super(key: key);

  @override
  State<GformWebViewFlow> createState() => _GformWebViewFlowState();
}

class _GformWebViewFlowState extends State<GformWebViewFlow> {
  @override
  Widget build(BuildContext context) {
    return BaseView<GformWebViewFlowModel>(onModelReady: (model) {
      model.getWebViewUrl(widget.httpPayload);
    }, builder: (context, model, child) {
      return Scaffold(
          appBar: myAppBar('AQG'),
          drawer: myAppDrawer(context),
          body: Container(
            child: model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: WebView(
                      userAgent: "random",
                      initialUrl: model.webViewurl,
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),
          ));
    });
  }
}
