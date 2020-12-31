import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common/common_bg_inner_container.dart';

class FoodOrderScreen extends StatefulWidget {
  final foodUrl;

  const FoodOrderScreen({Key key, @required this.foodUrl}) : super(key: key);

  @override
  _FoodOrderScreenState createState() => _FoodOrderScreenState();
}

class _FoodOrderScreenState extends State<FoodOrderScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  var _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: CommonBgInnerContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Order Food"),
            centerTitle: true,
          ),
          body: Stack(children: [
            WebView(
              onPageFinished: (_) {
                if(mounted)
                setState(() {
                  _isLoading = false;
                });
              },
              onPageStarted: (_) {
                if(mounted)
                setState(() {
                  _isLoading = true;
                });
              },
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.foodUrl,
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
