import 'package:clock_app/enums.dart';
import 'models/alarm_info.dart';
import 'models/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock, title: 'Clock', icon: 0),
  MenuInfo(MenuType.home, title: 'Home', icon: 1),
  MenuInfo(MenuType.profile, title: 'Profile', icon: 2),
  MenuInfo(MenuType.alarm, title: 'Plans', icon: 3),
  MenuInfo(MenuType.statistics, title: 'Statistics', icon: 4),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      title: 'Office',
      planCost: '250',
      gradientColorIndex: 0),
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 2)),
      title: 'Sport',
      planCost: '250',
      gradientColorIndex: 1),
];
