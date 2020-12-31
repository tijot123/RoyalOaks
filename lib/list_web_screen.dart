import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/button_info_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common/common_bg_inner_container.dart';

class ListWebScreen extends StatefulWidget {
  final Menu menu;

  const ListWebScreen({Key key, @required this.menu}) : super(key: key);

  @override
  _ListWebScreenState createState() => _ListWebScreenState();
}

class _ListWebScreenState extends State<ListWebScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  var _isLoading = true;

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.menu.link.contains(".pdf")
        ? 'https://docs.google.com/gview?embedded=true&url=${widget.menu.link}'
        : widget.menu.link);
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: CommonBgInnerContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(widget.menu.menuText),
            centerTitle: true,
          ),
          body: Stack(children: [
            WebView(
              onPageFinished: (_) {
                setState(() {
                  _isLoading = false;
                });
              },
              onPageStarted: (_) {
                setState(() {
                  _isLoading = true;
                });
              },
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.menu.link.contains(".pdf")
                  ? 'https://docs.google.com/gview?embedded=true&url=${widget.menu.link}'
                  : widget.menu.link,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Visibility(
                visible: _isLoading,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.greenAccent,
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  //Make sure this function return Future<bool> otherwise you will get an error
  Future<bool> _onWillPop(BuildContext context) async {
    var webViewController = await _controller.future;
    if (await webViewController.canGoBack()) {
      webViewController.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
