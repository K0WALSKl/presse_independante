import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLoader extends StatefulWidget {
  const WebViewLoader({required Key? key, required this.url}) : super(key: key);

  final String? url;

  @override
  State<StatefulWidget> createState() => WebViewUi();
}

class WebViewUi extends State<WebViewLoader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.grey[700],
          brightness: Brightness.light,
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                }),
          ],
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }

  Future<void> choiceAction(String value) async {
    if (value == Constants.openInBrowser) {
      if (await canLaunch(widget.url!)) {
        await launch(widget.url!);
      } else {
        throw 'Impossible de lancer ce lien dans votre navigateur';
      }
    }
  }
}

class Constants {
  static const String openInBrowser = 'Ouvrir dans le navigateur';
  static const List<String> choices = <String>[openInBrowser];
}
