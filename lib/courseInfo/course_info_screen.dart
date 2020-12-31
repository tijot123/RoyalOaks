import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/common/common_bg_inner_container.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseInfoScreen extends StatefulWidget {
  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> {
  String _version = "";
  String _htmlContent = "";

  @override
  void initState() {
    _getVersionData();
    _loadHtmlFromAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBgInnerContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Course Info"),
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Image.asset(
                  "assets/img/splash_logo.png",
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _version,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(
                    onLinkTap: (url) {
                      _launchWebUrl(url);
                    },
                    data: _htmlContent,
                    defaultTextStyle:
                        TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/course_info.html');
    if(mounted)
    setState(() {
      _htmlContent = fileText;
    });
  }

  void _getVersionData() {
    PackageInfo.fromPlatform().then((value) {
      if(mounted)
      setState(() {
        _version = "Version ${value.version}";
      });
    });
  }

  _launchWebUrl(String mUrl) async {
    if (await canLaunch(mUrl)) {
      await launch(mUrl);
    } else {
      throw 'Could not launch $mUrl';
    }
  }
}
