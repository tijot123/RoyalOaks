import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/common_bg_inner_container.dart';
import 'package:flutter_app/helper/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TeeTimesScreen extends StatefulWidget {
  @override
  _TeeTimesScreenState createState() => _TeeTimesScreenState();
}

class _TeeTimesScreenState extends State<TeeTimesScreen> {
  String memberId = "";
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  var _isLoading = true;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        memberId = value.getString(USER_ID);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: CommonBgInnerContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text(""),
          ),
          body: Stack(
            children: [
              memberId != ""
                  ? WebView(
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
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller.complete(webViewController);
                      },
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl:
                          "https://web.foretees.com/v5/servlet/Login?caller=PDG4735&clubname=royaloaks&user_name=$memberId",
                    )
                  : Visibility(
                      visible: _isLoading,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.greenAccent,
                        ),
                      ),
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
            ],
          ),
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
