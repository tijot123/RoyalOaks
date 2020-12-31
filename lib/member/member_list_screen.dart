import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/api/api_provider.dart';
import 'package:flutter_app/common/common_bg_inner_container.dart';
import 'package:flutter_app/model/member_model.dart';

import 'member_details_screen.dart';

class MemberListScreen extends StatefulWidget {
  @override
  _MemberListScreenState createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  var _isMemberListEmpty = true;
  List<Datum> data = [];
  List<Datum> tempData = [];

  @override
  void initState() {
    _fetchMemberList();
    super.initState();
  }

  _fetchMemberList() {
    if(mounted)
    setState(() {
      _isMemberListEmpty = true;
    });
    ApiProvider().membersRequest().then((value) {
      if (value.status == 200) {
        if(mounted)
        setState(() {
          data = value.data;
          tempData = value.data;
          _isMemberListEmpty = false;
        });
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonBgInnerContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                _fetchMemberList();
              },
            )
          ],
          centerTitle: true,
          title: Text("Members"),
        ),
        body: Column(
          children: [
            Visibility(
              visible: !_isMemberListEmpty,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: "Search member",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, style: BorderStyle.solid),
                      ),
                      fillColor: Colors.white),
                  autocorrect: true,
                  maxLines: 1,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    debugPrint(value);
                    data = [];
                    for (int j = 0; j < tempData.length; j++) {
                      if (tempData[j]
                          .displayName
                          .toLowerCase()
                          .contains(value.toLowerCase())) {
                        data.add(tempData[j]);
                      }
                    }
                    if(mounted)
                    setState(() {
                      data = data;
                    });
                  },
                ),
              ),
            ),
            _isMemberListEmpty
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (ctx, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MemberDetailsScreen(
                                        data: data[index],
                                      )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xFF669900),
                                    border: Border.all(
                                        color: Colors.white70, width: 2)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data[index].displayName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
