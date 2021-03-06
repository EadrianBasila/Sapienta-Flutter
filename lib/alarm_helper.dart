import 'package:clock_app/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'neumorphic_expenses/pie_chart.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPlanTitle = 'planTitle';
final String columnPlanCost = 'planCost';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';

class AlarmHelper {
  static Database _database;
  static AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            '''
          create table $tableAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPlanTitle text not null,
          $columnPlanCost text not null,
          $columnPending integer,
          $columnColorIndex integer)
        ''');
      },
    );
    return database;
  }

  Future<int> getCount() async {
    //database connection
    var db = await this.database;
    var x = await db.rawQuery('SELECT COUNT (*) from $tableAlarm');
    int count = Sqflite.firstIntValue(x);
    return Future.value(count);
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);

      //kCategories.add(alarmInfo);
    });

    return _alarms;
  }

  void getPlans() async {
    List<Category> _kcat = [];
    var db = await this.database;
    var result = await db.query(tableAlarm);
    if (result != null) {
      result.forEach((element) {
        var alarmInfo = AlarmInfo.fromMap(element);
        var cost = double.parse(alarmInfo.planCost);
        var title = alarmInfo.planTitle.toString();
        var ins = Category(title, planCost: cost);
        //kCategories.add(ins);
        _kcat.add(ins);
        print('Added: $title $cost');
      });
      //kCategories = List.from(_kcat);
      kCategories = _kcat;
      print('============================================');
      print('DATA LOADED');
      print('============================================');
    }
  }

  Future<double> getCost() async {
    var db = await this.database;
    var result = await db.query(tableAlarm);
    double costTotal = 0.0;
    if (result != null) {
      result.forEach((element) {
        var alarmInfo = AlarmInfo.fromMap(element);
        var cost = double.parse(alarmInfo.planCost);
        print(cost);
        costTotal += cost;
        print(costTotal);
      });
    }
    print("Total: $costTotal");
    return Future.value(costTotal);
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
}
