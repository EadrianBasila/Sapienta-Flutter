import 'dart:io';
import 'package:clock_app/constants/theme_data.dart';
import 'package:clock_app/neumorphic_expenses/categories_row.dart';
import 'package:clock_app/neumorphic_expenses/pie_chart_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class DashPage extends StatefulWidget {
  @override
  _DashPageState createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  String _planCounts;
  String _userSalary = '69,420.00';
  String _userName = 'Hatdog';
  PickedFile _imageFile;


 

  @override
  Widget build(BuildContext context) { 
  var now = DateTime.now();  
  final height = MediaQuery.of(context).size.height;
  var formattedDate = DateFormat('EEE, d MMM yyyy').format(now);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 32),
      child: ListView(
        children:<Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hi $_userName',
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
                    backgroundImage: _imageFile == null
                        ? AssetImage('images/profile-default.png')
                        : FileImage(File(_imageFile.path)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,), ////////////====================/////////////////
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
                            color: GradientColors.mango.last.withOpacity(0.4),
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
                          Text('6', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.primaryTextColor,
                              fontSize: 36),
                              ),
                          Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Text('Active Plans', style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: CustomColors.primaryTextColor,
                                fontSize: 12),
                                ),
                          ),                     
                        ],
                      ),
                    ),                  
                  SizedBox(width: 10,),
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
                            color: GradientColors.sea.last.withOpacity(0.4),
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
                          Text('$_userSalary', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.primaryTextColor,
                              fontSize: 27),
                              ),
                          Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Text('Remaining Salary', style: TextStyle(
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
            SizedBox(height: 10,),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 150,
                    width: 150,
                      child:Expanded(child: Column(
                    children: <Widget>[
                      PieChartView(),
                    ],),)
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: Container( 
                      padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(                 
                        gradient: LinearGradient(
                          colors: GradientColors.sunset,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: GradientColors.sunset.last.withOpacity(0.4),
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
            )
          ),
          SizedBox(height: 10,), 
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
                          colors: GradientColors.sea,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: GradientColors.sea.last.withOpacity(0.4),
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
                          Text('$_userSalary', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.primaryTextColor,
                              fontSize: 27),
                              ),
                          Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Text('Remaining Salary', style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: CustomColors.primaryTextColor,
                                fontSize: 12),
                                ),
                          ),                     
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
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
                            color: GradientColors.mango.last.withOpacity(0.4),
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
                          Text('6', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.primaryTextColor,
                              fontSize: 36),
                              ),
                          Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Text('Active Plans', style: TextStyle(
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
            SizedBox(height: 10,),
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
                          colors: GradientColors.sunset,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: GradientColors.sunset.last.withOpacity(0.4),
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
                  SizedBox(width: 10,),
                  Container(
                    height: 150,
                    width: 150,
                      child:Expanded(child: Column(
                    children: <Widget>[
                      PieChartView(),
                    ],),)
                  ),
                 
                ],
            )
          ),
        ]
      ),
    );
  }
}
