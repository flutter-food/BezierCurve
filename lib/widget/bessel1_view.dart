import 'package:flutter/material.dart';

class Point {
  double x;
  double y;
  Point({this.x,this.y});
}

class BesselView extends CustomPainter{

  final double radius;
  final double M = 0.551915024494;
  final double percent;
  final bool isToRight;
  final Color color;
  Paint curvePaint;
  Path curvePath;

  BesselView({
    @required this.radius,
    @required this.percent,
    @required this.isToRight,
    @required this.color
  }){
    curvePaint = Paint()
      ..style = PaintingStyle.fill;
    curvePath = Path();
  }

  @override
  void paint(Canvas canvas, Size size) {
    curvePath.reset();
    curvePaint.color = this.color;
    _canvasBesselPath(curvePath);
    canvas.drawPath(curvePath, curvePaint);
  }

  void _canvasBesselPath(Path path) {

    Point p1 = Point(x: radius*2,y: radius);
    Point p2 = Point(x: radius,y: radius*2);
    Point p3 = Point(x: 0,y: radius);
    Point p4 = Point(x: radius,y: 0);

    if (isToRight) {
      if (percent <= 0.2) {
        p1.x = radius*2 + radius*percent/0.2;
      } else if (percent <= 0.4) {
        p4.x = p2.x = radius + radius*(percent-0.2)/0.2;
        p1.x = p2.x + radius*2;
      } else if (percent <= 0.6) {
        p4.x = p2.x = radius*2 ;
        p1.x = radius*4 - radius*(percent - 0.4)/0.2;
      } else if (percent <= 0.8) {
        p4.x = p2.x = radius*2 - radius*(percent - 0.6)/0.2;
        p1.x = p2.x+radius;
      } else if (percent <= 0.9) {
        p3.x = radius*(percent - 0.8)/0.3;
        p4.x = p2.x = radius;
        p1.x = radius*2;
      } else if (percent <= 1.0) {
        p3.x = radius*(1 - percent)/0.3;
        p4.x = p2.x = radius;
        p1.x = radius*2;
      }
    } else {
      if (percent <= 0.2) {
        p3.x = - radius*percent/0.2;
      } else if (percent <= 0.4) {
        p3.x = -radius - radius*(percent-0.2)/0.2;
        p4.x = p2.x = p3.x + 2*radius;
      } else if (percent <= 0.6) {
        p3.x =  radius*(percent - 0.4)/0.2 - radius*2;
        p4.x = p2.x = 0;
      } else if (percent <= 0.8) {
        p3.x = -radius+radius*(percent - 0.6)/0.2;
        p4.x = p2.x = p3.x + radius;
        p1.x = p2.x + radius*2 - radius*(percent - 0.6)/0.2;
      } else if (percent <= 0.9) {
        p1.x = radius*2 - radius*(percent - 0.8)/0.3;
      } else if (percent <= 1.0) {
        p1.x = radius*2 - radius*(1 - percent)/0.3;
      }
    }

    final p1Radius = p2.y - p1.y;
    final p24LeftRadius = p2.x - p3.x;
    final p24RightRadius = p1.x - p2.x;
    final p3Radius = p2.y - p3.y;
    path.moveTo(p1.x, p1.y);
    path.cubicTo(
        p1.x, p1.y + p1Radius*M,
        p2.x + p24RightRadius*M, p2.y,
        p2.x, p2.y
    );
    path.cubicTo(
        p2.x - p24LeftRadius*M, p2.y,
        p3.x, p3.y + p3Radius*M,
        p3.x, p3.y
    );
    path.cubicTo(
        p3.x, p3.y - p3Radius*M,
        p4.x - p24LeftRadius*M, p4.y,
        p4.x, p4.y
    );
    path.cubicTo(
        p4.x + p24RightRadius*M, p4.y,
        p1.x , p1.y - p1Radius*M,
        p1.x, p1.y
    );

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}