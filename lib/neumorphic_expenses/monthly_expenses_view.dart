import 'package:clock_app/neumorphic_expenses/pie_chart_view.dart';
import 'package:flutter/material.dart';

class MonthlyExpensesView extends StatefulWidget {
  @override
  _MonthlyExpensesViewState createState() => _MonthlyExpensesViewState();
}

class _MonthlyExpensesViewState extends State<MonthlyExpensesView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: Column(
                    children: <Widget>[
                      PieChartView(),
                    ],
                  )),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}



