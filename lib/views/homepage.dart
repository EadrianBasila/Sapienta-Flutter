import 'package:clock_app/constants/theme_data.dart';
import 'package:clock_app/data.dart';
import 'package:clock_app/enums.dart';
import 'package:clock_app/models/menu_info.dart';
import 'package:clock_app/views/alarm_page.dart';
import 'package:clock_app/views/clock_page.dart';
import 'package:clock_app/views/profile_page.dart';
import 'package:clock_app/views/dash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),
          VerticalDivider(
            color: CustomColors.dividerColor,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget child) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm)
                  return AlarmPage();
                else if (value.menuType == MenuType.profile)
                  return ProfilePage();
                else if (value.menuType == MenuType.home)
                  return DashPage();
                // else if (value.menuType == MenuType.statistics)
                //   return MonthlyExpensesView();
                else
                  return Container(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(text: 'Unimplemented Page\n'),
                          TextSpan(
                            text: value.title,
                            style: TextStyle(fontSize: 48),
                          ),
                        ],
                      ),
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<IconData> _icons = [
    // The underscore declares a variable as private in dart.
    Icons.access_alarms_rounded,
    Icons.amp_stories_rounded,
    Icons.account_circle,
    Icons.bookmark_border_rounded,
    Icons.analytics_outlined
  ];

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return Container(
            decoration: BoxDecoration(
                color: currentMenuInfo.menuType == value.menuType
                    ? Color(0xFF242634): Colors.transparent,

                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
),
            child: TextButton(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
              ),
              onPressed: () {
                var menuInfo = Provider.of<MenuInfo>(context, listen: false);
                menuInfo.updateMenu(currentMenuInfo);
                
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    _icons[currentMenuInfo.icon],
                    color: currentMenuInfo.menuType == value.menuType
                    ? Colors.deepPurple[900]: Colors.white,
                    size: 40.0,
                  ),
                  SizedBox(height: 8),
                  Text(currentMenuInfo.title ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 9)),
                ],
              ),
            ));
      },
    );
  }
}

