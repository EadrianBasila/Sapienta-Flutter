import 'package:flutter/material.dart';
import 'dart:math';

class PieChart extends CustomPainter {
  PieChart({
    @required this.categories,
    @required this.width,
  });

  List<Category> categories;
  double width;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    categories.forEach((expense) => total += expense.planCost);

    double startRadian = -pi / 2;

    for (var index = 0; index < categories.length; index++) {
      final currentCategory = categories.elementAt(index);
      final sweepRadian = currentCategory.planCost / total * 2 * pi;
      paint.color = kNeumorphicColors.elementAt(index % categories.length);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );
      startRadian += sweepRadian;
    }
  }

  @override
  shouldRepaint(CustomPainter oldDelegate) => true;
}

class PlanVals {}

class Category {
  Category(this.planTitle, {@required this.planCost});
   String planTitle;
   double planCost;
}

var kCategories = [

];

var kCategoriesB = [
  Category('Netflix', planCost: 500.00),
  Category('Youtube', planCost: 150.00),
  Category('Spotify', planCost: 90.00),
  Category('HBO Max', planCost: 90.00),
  Category('Roku Family', planCost: 40.00),
  Category('Hulu +', planCost: 20.00),
];

final kNeumorphicColors = [
  Color.fromRGBO(82, 98, 255, 1),
  Color.fromRGBO(46, 198, 255, 1),
  Color.fromRGBO(123, 201, 82, 1),
  Color.fromRGBO(255, 171, 67, 1),
  Color.fromRGBO(252, 91, 57, 1),
  Color.fromRGBO(139, 135, 130, 1),
  Color.fromRGBO(255, 0, 255, 1),
  Color.fromRGBO(128, 255, 0, 1),
  Color.fromRGBO(0, 255, 255, 1),
  Color.fromRGBO(255, 191, 0, 1),
];
