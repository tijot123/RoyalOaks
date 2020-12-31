import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_provider.dart';
import 'package:flutter_app/common/common_bg_inner_container.dart';
import 'package:flutter_app/list_web_screen.dart';

import 'model/button_info_model.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Menu> menus = [];

  @override
  void initState() {
    ApiProvider().requestButtonInfo().then((value) {
      if (mounted)
        setState(() {
          menus = value.data.menus;
        });
    }).catchError((error) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBgInnerContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Lists"),
          centerTitle: true,
        ),
        body: menus.length == 0
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : ListView.builder(
                itemCount: menus.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ListWebScreen(menu: menus[index])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF669900),
                            border:
                                Border.all(color: Colors.white70, width: 2)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                menus[index].icon,
                                height: 30,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  menus[index].menuText,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
