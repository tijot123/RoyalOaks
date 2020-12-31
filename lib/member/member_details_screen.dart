import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_provider.dart';
import 'package:flutter_app/common/common_bg_inner_container.dart';
import 'package:flutter_app/model/member_details_model.dart';
import 'package:flutter_app/model/member_model.dart';

import 'package:url_launcher/url_launcher.dart';

class MemberDetailsScreen extends StatefulWidget {
  final Datum data;

  const MemberDetailsScreen({Key key, @required this.data}) : super(key: key);

  @override
  _MemberDetailsScreenState createState() => _MemberDetailsScreenState();
}

class _MemberDetailsScreenState extends State<MemberDetailsScreen> {
  MemberDetailsModel _memberDetailsModel;

  @override
  void initState() {
    ApiProvider().requestMemberDetails(widget.data.userId).then((value) {
      if(mounted)
      setState(() {
        _memberDetailsModel = value;
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
          title: Text(widget.data.displayName),
          centerTitle: true,
        ),
        body: _memberDetailsModel == null
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              )
            : SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeadingView("Personal Information"),
                        _buildLineInBetween(),
                        _buildSimpleTextView(
                            "Gender: ${_memberDetailsModel.data.gender}"),
                        _buildSimpleTextView(
                            "Date of Birth: ${_memberDetailsModel.data.dateOfBirth}"),
                        Visibility(
                            visible: _memberDetailsModel.data.email != "" ||
                                _memberDetailsModel.data.cellPhone != "",
                            child: _buildHeadingView("Contact Information")),
                        Visibility(
                            visible: _memberDetailsModel.data.email != "" ||
                                _memberDetailsModel.data.cellPhone != "",
                            child: _buildLineInBetween()),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Visibility(
                                visible: _memberDetailsModel.data.email != "",
                                child: _buildSimpleTextView(
                                    "Email: ${_memberDetailsModel.data.email}"),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Visibility(
                                visible: _memberDetailsModel.data.email != "",
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(8, 2, 8, 0),
                                  child: IconButton(
                                    icon: Icon(Icons.mail),
                                    onPressed: () {
                                      _sendMail(_memberDetailsModel.data.email);
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Visibility(
                                visible:
                                    _memberDetailsModel.data.cellPhone != "",
                                child: _buildSimpleTextView(
                                    "Phone: ${_memberDetailsModel.data.cellPhone}"),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Visibility(
                                visible:
                                    _memberDetailsModel.data.cellPhone != "",
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(8, 2, 8, 0),
                                  child: IconButton(
                                    icon: Icon(Icons.phone),
                                    onPressed: () {
                                      _launchCaller(
                                          "tel:${_memberDetailsModel.data.cellPhone}");
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        _buildHeadingView("Address Information"),
                        _buildLineInBetween(),
                        _buildSimpleTextView(
                            _memberDetailsModel.data.fullAddress),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLineInBetween() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        height: 2,
        color: Color(0xFFCAE4BA),
      ),
    );
  }

  Widget _buildSimpleTextView(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
      child: Text(
        title,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _buildHeadingView(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<void> _sendMail(String mailId) async {
    // Android and iOS
    String uri = 'mailto:$mailId';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  _launchCaller(String tel) async {
    if (await canLaunch(tel)) {
      await launch(tel);
    } else {
      throw 'Could not launch $tel';
    }
  }
}
