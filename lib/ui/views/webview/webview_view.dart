import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLoader extends StatefulWidget {
  final String url;

  const WebViewLoader({Key key, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WebViewUi();
}

class WebViewUi extends State<WebViewLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
