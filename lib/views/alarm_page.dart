import 'package:clock_app/alarm_helper.dart';
import 'package:clock_app/constants/theme_data.dart';
import 'package:clock_app/models/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../main.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime _alarmTime;
  String _alarmTimeString;
  String _subscriptionTitle; //new string parameter
  String _planCost; //new string parameter
  bool _isRepeatSelected = false;
  AlarmHelper _alarmHelper = AlarmHelper();

  final TextEditingController myController1 = TextEditingController();
  final TextEditingController myController2 = TextEditingController();
  Future<List<AlarmInfo>> _alarms;
  List<AlarmInfo> _currentAlarms;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Subscription Plans',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 24),
          ),
          Expanded(
            flex: 2,
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentAlarms = snapshot.data;
                  return ListView(
                    children: snapshot.data.map<Widget>((alarm) {
                      var planCost = alarm.planCost;
                      var planTitle = alarm.planTitle;
                      var alarmTime =
                          DateFormat('hh:mm aa').format(alarm.alarmDateTime);
                      var gradientColor = GradientTemplate
                          .gradientTemplate[alarm.gradientColorIndex].colors;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColor,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: gradientColor.last.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                              //offset: Offset(4, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.art_track_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      alarm.title,
                                      style: TextStyle(
                                        color: Colors.white, fontSize: 18
                                      ),
                                    )
                                  ],
                                ),
                                Switch(
                                  onChanged: (bool value) {},
                                  value: true,
                                  activeColor: Colors.white,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  planTitle,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Cost: $planCost',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  alarmTime,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.white,
                                    onPressed: () {
                                      deleteAlarm(alarm.id);
                                    }),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).followedBy([
                      if (_currentAlarms.length < 10)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.menuBackgroundColor.withOpacity(0.9),
                                blurRadius: 8,
                                spreadRadius: 4,
                              ),
                            ],
                            color: CustomColors.menuBackgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                            ),
                            onPressed: () {
                              _alarmTimeString =
                                  DateFormat('HH:mm').format(DateTime.now());
                              showModalBottomSheet(
                                useRootNavigator: true,
                                context: context,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setModalState) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF2D2F41),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(24),
                                              topLeft: Radius.circular(24)),
                                        ),
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          children: [
                                            TextButton(
                                              onPressed: () async {
                                                var selectedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if (selectedTime != null) {
                                                  final now = DateTime.now();
                                                  var selectedDateTime =
                                                      DateTime(
                                                          now.year,
                                                          now.month,
                                                          now.day,
                                                          selectedTime.hour,
                                                          selectedTime.minute);
                                                  _alarmTime = selectedDateTime;
                                                  setModalState(() {
                                                    _alarmTimeString =
                                                        DateFormat('HH:mm')
                                                            .format(
                                                                selectedDateTime);
                                                  });
                                                }
                                              },
                                              child: Text(
                                                _alarmTimeString,
                                                style: TextStyle(
                                                    fontSize: 54,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                'Repeat',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                              trailing: Switch(
                                                activeColor: Colors.white,
                                                onChanged: (value) {
                                                  setModalState(() {
                                                    _isRepeatSelected = value;
                                                  });
                                                },
                                                value: _isRepeatSelected,
                                              ),
                                            ),
                                            TextFormField(
                                              controller: myController1,
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return 'Enter Subscription Cost';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText:
                                                      'Susbcription Name',
                                                  labelStyle: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  filled: true,
                                                  isDense: true,
                                                  prefixIcon: Icon(
                                                      Icons.class__rounded,
                                                      color: Colors.white)),
                                            ),
                                            SizedBox(height: 10),
                                            TextFormField(
                                              controller: myController2,
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return 'Enter Subscription Cost';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText:
                                                      'Subscription Cost',
                                                  labelStyle: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  filled: true,
                                                  isDense: true,
                                                  prefixIcon: Icon(
                                                      Icons.local_atm_outlined,
                                                      color: Colors.white)),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              child:
                                                  FloatingActionButton.extended(
                                                onPressed: () {
                                                  _subscriptionTitle =
                                                      myController1.text;
                                                  _planCost =
                                                      myController2.text;
                                                  onSaveAlarm(
                                                      _subscriptionTitle,
                                                      _planCost,
                                                      _isRepeatSelected);
                                                },
                                                icon: Icon(Icons.alarm),
                                                label: Text('Save',
                                                    style: TextStyle(
                                                        fontSize: 24)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                              // scheduleAlarm();
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.access_alarm_rounded,
                                    color: Colors.white, size: 24),
                                SizedBox(height: 8),
                                Text(
                                  'Add a new subscription plan',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Center(
                            child: Text(
                          'Only 10 subscriptions allowed!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                    ]).toList(),
                  );
                }
                return Center(
                  child: Text(
                    'Loading..',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo,
      {bool isRepeating}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    if (isRepeating)
      await flutterLocalNotificationsPlugin.showDailyAtTime(
          0,
          'Subscription Reminder: ',
          alarmInfo.title,
          Time(
              scheduledNotificationDateTime.hour,
              scheduledNotificationDateTime.minute,
              scheduledNotificationDateTime.second),
          platformChannelSpecifics);
    else
      await flutterLocalNotificationsPlugin.schedule(
          0,
          'Subscription Reminder: ',
          alarmInfo.title,
          scheduledNotificationDateTime,
          platformChannelSpecifics);
  }

  //void onSaveAlarm(String _subscriptionTitle, bool _isRepeating) {
  void onSaveAlarm(
      String _subscriptionTitle, String _planCost, bool _isRepeating) {
    String pTitle = _subscriptionTitle;
    String cost = _planCost;

    int max = 5;
    int randomNumber = Random().nextInt(max);
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));
    //scheduleAlarmDateTime = _alarmTime.add(Duration(days: 30));
    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: randomNumber,
      title: 'Subscription',
      planTitle: '$pTitle',
      planCost: '$cost',
    );

    print(
        "==================================================================================================================================================================");
    print(alarmInfo.planTitle);
    print(alarmInfo.planCost);
    _alarmHelper.insertAlarm(alarmInfo);
    print(
        "==================================================================================================================================================================");
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo, isRepeating: _isRepeating);
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
}
