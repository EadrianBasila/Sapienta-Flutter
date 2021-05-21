import 'package:clock_app/neumorphic_expenses/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/constants/theme_data.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
    flex:4,
    child: LayoutBuilder(
      builder: (context,constraint)=> Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
                            colors: GradientColors.sky,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
          borderRadius: BorderRadius.all(Radius.circular(55)),
          boxShadow: [BoxShadow(
            spreadRadius: -10,
            blurRadius: 17,
            offset: Offset(-2,-2),
            color: GradientColors.sky.last.withOpacity(0.4),
          ),
          BoxShadow(
            spreadRadius: -2,
            blurRadius: 10,
            offset: Offset(7,7),
            color: GradientColors.sky.first.withOpacity(0.4),
          ),
          ],
        ),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: constraint.maxWidth* 0.6,
              child: CustomPaint(
                child: Center(),
                foregroundPainter: PieChart(
                  width: constraint.maxWidth*0.5,
                  categories: kCategories,                                 
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              height: constraint.maxWidth * 0.4,
              decoration: BoxDecoration(
               gradient: LinearGradient(
                            colors: GradientColors.sky,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(
                blurRadius: 1,
                offset: Offset(-1,-1),
                color: Colors.black.withOpacity(0.5),
              ),
              BoxShadow(
                spreadRadius: -2,
                blurRadius: 10,
                offset: Offset(5,5),
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
            child: Center(
              child: Text('PLANS', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)
            ),
          ),)
        ],
      ),
      ),      
    ));
  }
}