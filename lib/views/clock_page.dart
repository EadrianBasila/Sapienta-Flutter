import 'dart:async';

import 'package:clock_app/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'clockview.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      alignment: Alignment.center,
      color: Color(0xFF2d2F41),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              'Clock',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DigitalClockWidget(),
                Text(
                  formattedDate,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: Align(
                  alignment: Alignment.center,
                  child: ClockView(
                    size: MediaQuery.of(context).size.height / 3,
                  ))),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Timezone',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'UTC' + offsetSign + timezoneString,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                   
                  ],
                ), 
                SizedBox(height: 8),

                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                        child: Column(
                          children: [
                            Text(
                              'Sapienta Iris',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              'Subscription Manager Application [May 2021]',
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ],
                        ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({
    Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DigitalClockWidgetState();
  }
}

class DigitalClockWidgetState extends State<DigitalClockWidget> {
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      var perviousMinute = DateTime.now().add(Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      if (perviousMinute != currentMinute)
        setState(() {
          formattedTime = DateFormat('HH:mm').format(DateTime.now());
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('=====>digital clock updated');
    return Text(
      formattedTime,
      style: TextStyle(
          color: CustomColors.primaryTextColor,
          fontSize: 64),
    );
  }
}
