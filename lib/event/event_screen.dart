import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_provider.dart';
import 'package:flutter_app/common/common_bg_inner_container.dart';
import 'package:flutter_app/common/common_snackbar.dart';
import 'package:flutter_app/model/events_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  List<Datum> data = [];
  SharedPreferences prefs;
  EventsModel _eventsModel;

  @override
  void initState() {
    DeviceCalendarPlugin().requestPermissions().then((value) {});

    _getSharedPreferences();
    ApiProvider().eventsRequest().then((value) {
      if (mounted)
        setState(() {
          _eventsModel = value;
          data = value.data;
        });
    }).catchError((error) {
      CommonSnackBar.showSnackBar(context, error.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBgInnerContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Events"),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                data != null
                    ? ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data[index].eventTitle,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Visibility(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(data[index]
                                          .eventDescription
                                          .toString()
                                          .trim()),
                                    ),
                                    visible:
                                        data[index].eventDescription != null,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: "Time: ",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text:
                                                      "${data[index].eventTime.toString()}")
                                            ]),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: "Date: ",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text:
                                                      "${data[index].eventDate.year.toString()}-${data[index].eventDate.month.toString()}-${data[index].eventDate.day.toString()}")
                                            ]),
                                          ),
                                        ),
                                        Align(
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: prefs.getString(
                                                            data[index]
                                                                .eventId) !=
                                                        null
                                                    ? Colors.transparent
                                                    : Color(0xFF669900),
                                                border: Border.all(
                                                    color: Colors.white70,
                                                    width: 2)),
                                            child: FlatButton(
                                              onPressed: prefs.getString(
                                                          data[index]
                                                              .eventId) !=
                                                      null
                                                  ? null
                                                  : () {
                                                      final Event event = Event(
                                                        data[index].eventId,
                                                        eventId:
                                                            data[index].eventId,
                                                        title: data[index]
                                                            .eventTitle,
                                                        description: data[index]
                                                            .eventDescription,
                                                        start: data[index]
                                                            .eventDate,
                                                        end: data[index]
                                                            .eventDate,
                                                      );
                                                      DeviceCalendarPlugin()
                                                          .createOrUpdateEvent(
                                                              event)
                                                          .then((value) {
                                                        CommonSnackBar.showSnackBar(
                                                            context,
                                                            "Event Added to Calendar successfully");
                                                        _addEventToSharedPreferences(
                                                            data, index);
                                                        if (mounted)
                                                          setState(() {
                                                            data = data;
                                                          });
                                                      });
                                                    },
                                              child: Text("Add To Calender"),
                                            ),
                                          ),
                                          alignment: Alignment.centerRight,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: Text(
                          _eventsModel.statusMessage,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                data != null && data.length == 0
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.greenAccent,
                        ),
                      )
                    : Stack()
              ],
            );
          },
        ),
      ),
    );
  }

  _addEventToSharedPreferences(List<Datum> data, int index) {
    prefs.setString(data[index].eventId, data[index].eventTitle);
  }

  void _getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
}
