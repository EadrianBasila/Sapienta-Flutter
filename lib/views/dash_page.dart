import 'dart:io';
import 'package:clock_app/alarm_helper.dart';
import 'package:clock_app/constants/theme_data.dart';
import 'package:clock_app/models/alarm_info.dart';
import 'package:clock_app/neumorphic_expenses/categories_row.dart';
import 'package:clock_app/neumorphic_expenses/pie_chart_view.dart';
import 'package:clock_app/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashPage extends StatefulWidget {
  @override
  _DashPageState createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  AlarmHelper _alarmHelper = AlarmHelper();
  SharedPref sharedPref = SharedPref();
  ProfileInfo userLoad = ProfileInfo();
  static var _planCount;

  /////////////////////////////////
  Future<List<AlarmInfo>> _alarms;
  List<AlarmInfo> _currentAlarms;

  @override
  void initState() {
    loadSharedPrefs();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    _alarmHelper.getCount().then((value) {
      _planCount = value.toString();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }
  ///////////////////////////////////

  loadSharedPrefs() async {
    try {
      ProfileInfo user = ProfileInfo.fromJson(await sharedPref.read("user"));
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("Loaded!"),
          duration: const Duration(milliseconds: 500)));
      setState(() {
        userLoad = user;
      });
    } catch (Excepetion) {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("Nothing found!"),
          duration: const Duration(milliseconds: 500)));
    }
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedDate = DateFormat('EEE, d MMM yyyy').format(now);
    var sg = SalaryGrade();

    String _userName = userLoad.userName ?? "Username";
    var _userNameTruncated = _userName.replaceRange(7, _userName.length, '..');
    String _userSalary = userLoad.userSalary ?? "0";
    String _userPosition = userLoad.userPosition ?? "Work Position";
    sg.getGrade = int.parse(_userSalary);

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 32),
        child: new FutureBuilder(
            future: _alarms,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _currentAlarms = snapshot.data;
                return ListView(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Hi $_userNameTruncated',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColors.primaryTextColor,
                                fontSize: 32),
                          ),
                          Text(
                            '$formattedDate',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: CustomColors.primaryTextColor,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColors.menuBackgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.menuBackgroundColor,
                              blurRadius: 4,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: userLoad.imagePath == null
                              ? AssetImage('images/profile-default.png')
                              : FileImage(File(userLoad.imagePath)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ), ////////////====================/////////////////
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: GradientColors.mango,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    GradientColors.mango.last.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '$_planCount',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.primaryTextColor,
                                    fontSize: 36),
                              ),
                              Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Text(
                                  'Active Plans',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: CustomColors.primaryTextColor,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: GradientColors.sea,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      GradientColors.sea.last.withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '$_userSalary',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.primaryTextColor,
                                      fontSize: 32),
                                ),
                                Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Text(
                                    'Remaining Salary',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: CustomColors.primaryTextColor,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  IntrinsicHeight(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                          height: 150,
                          width: 150,
                          child: Expanded(
                            child: Column(
                              children: <Widget>[
                                PieChartView(),
                              ],
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: GradientColors.cucumber,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: GradientColors.cucumber.last
                                    .withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: CategoriesRow(),
                        ),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: GradientColors.fresco,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: GradientColors.fresco.last
                                      .withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ///////////////////////// Total plan cost
                                Text(
                                  _userPosition,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.primaryTextColor,
                                      fontSize: 27),
                                ),
                                Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Text(
                                    'Work Position',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: CustomColors.primaryTextColor,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: GradientColors.retro,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    GradientColors.retro.last.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                sg.getGrade.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.primaryTextColor,
                                    fontSize: 36),
                              ),
                              Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Text(
                                  'Salary Grade',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: CustomColors.primaryTextColor,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  IntrinsicHeight(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: GradientColors.retro,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    GradientColors.retro.last.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Netflix',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.primaryTextColor,
                                        fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Cost: 500',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: CustomColors.primaryTextColor,
                                        fontSize: 14),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Spotify',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.primaryTextColor,
                                        fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Cost: 150',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: CustomColors.primaryTextColor,
                                        fontSize: 14),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Youtube ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.primaryTextColor,
                                        fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Cost: 90',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: CustomColors.primaryTextColor,
                                        fontSize: 14),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Upcomming subscriptions',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.primaryTextColor,
                                    fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ]);
              }
              return Center(
                child: Text(
                  'Loading..',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }));
  }
}

class CheckCount {
  AlarmHelper _alarmHelper = new AlarmHelper();
  checkValue() async {
    final value = await _alarmHelper.getCount().then((value) {});
    return value;
  }
}

class SalaryGrade {
  int grade;

  void set getGrade(int salary) {
    if (salary <= 11000) {
      grade = 1;
    } else if (salary > 11000 && salary <= 12000) {
      grade = 2;
    } else if (salary > 12000 && salary <= 13000) {
      grade = 3;
    } else if (salary > 13000 && salary <= 14000) {
      grade = 4;
    } else if (salary > 14000 && salary <= 15000) {
      grade = 5;
    } else if (salary > 15000 && salary <= 16000) {
      grade = 6;
    } else if (salary > 16000 && salary <= 17000) {
      grade = 7;
    } else if (salary > 17000 && salary <= 18000) {
      grade = 8;
    } else if (salary > 18000 && salary <= 20000) {
      grade = 9;
    } else if (salary > 20000 && salary <= 22000) {
      grade = 10;
    } else if (salary > 22000 && salary <= 24000) {
      grade = 11;
    } else if (salary > 24000 && salary <= 26000) {
      grade = 12;
    } else if (salary > 26000 && salary <= 29000) {
      grade = 13;
    } else if (salary > 29000 && salary <= 32000) {
      grade = 14;
    } else if (salary > 32000 && salary <= 35000) {
      grade = 15;
    } else if (salary > 35000 && salary <= 38000) {
      grade = 16;
    } else if (salary > 38000 && salary <= 42000) {
      grade = 17;
    } else if (salary > 42000 && salary <= 46000) {
      grade = 18;
    } else if (salary > 46000 && salary <= 52000) {
      grade = 19;
    } else if (salary > 52000 && salary <= 59000) {
      grade = 20;
    } else if (salary > 59000 && salary <= 66000) {
      grade = 21;
    } else if (salary > 66000 && salary <= 75000) {
      grade = 22;
    } else if (salary > 75000 && salary <= 85000) {
      grade = 23;
    } else if (salary > 85000 && salary <= 96000) {
      grade = 24;
    } else if (salary > 96000 && salary <= 109000) {
      grade = 25;
    } else if (salary > 109000 && salary <= 123000) {
      grade = 26;
    } else if (salary > 123000 && salary <= 139000) {
      grade = 27;
    } else if (salary > 139000 && salary <= 158000) {
      grade = 28;
    } else if (salary > 158000 && salary <= 178000) {
      grade = 29;
    } else if (salary > 178000 && salary <= 262000) {
      grade = 30;
    } else if (salary > 262000 && salary <= 313000) {
      grade = 31;
    } else if (salary > 313000 && salary <= 395000) {
      grade = 32;
    } else if (salary > 395000 && salary <= 407000) {
      grade = 33;
    } else {
      grade = 00;
    }
  }

  int get getGrade {
    return grade;
  }
}
