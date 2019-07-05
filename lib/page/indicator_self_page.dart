import 'package:flutter/material.dart';
import 'package:bezier_curve_master/utils/ui_util.dart';
import 'dart:math';

class IndicatorSelfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: Text("指示器"),
      ),
      body: _IndicatorView(),
    );
  }

}

class _IndicatorView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _IndicatorState();
  }

}

class WPosition {
  final double left;
  final double top;
  final double width;
  final double height;
  final Color color;
  WPosition({
    @required this.left,
    @required this.top,
    @required this.width,
    @required this.height,
    @required this.color
  });
}

class _IndicatorState extends State<_IndicatorView> with SingleTickerProviderStateMixin{

  double position = 0;
  final double widthRatio = 0.6;
  final double heightRatio = 0.4;
  //final double scaleRatio = 0.8;
  final double gapRatio = 0.1;
  double width;

  AnimationController _animationController;
  Animation<double> _animation;

  List<WPosition> _changePosition(double position) {

    double startLeft = width*(1-widthRatio)/2;
    double twoDistance = width*(widthRatio+gapRatio);

    WPosition wp1 = WPosition(
        left: startLeft - twoDistance*position,
        top: 0,
        width: width*widthRatio,
        height: width*heightRatio,
        color: Colors.red
    );

    WPosition wp2 = WPosition(
        left: startLeft - twoDistance*position + twoDistance,
        top: 0,
        width: width*widthRatio,
        height: width*heightRatio,
        color: Colors.deepOrangeAccent
    );

    WPosition wp3 = WPosition(
        left: startLeft - twoDistance*position + twoDistance*2,
        top: 0,
        width: width*widthRatio,
        height: width*heightRatio,
        color: Colors.amber
    );

    WPosition wp4 = WPosition(
        left: startLeft - twoDistance*position + twoDistance*3,
        top: 0,
        width: width*widthRatio,
        height: width*heightRatio,
        color: Colors.blue
    );

    WPosition wp5 = WPosition(
        left: startLeft - twoDistance*position + twoDistance*4,
        top: 0,
        width: width*widthRatio,
        height: width*heightRatio
    );

    List<WPosition> items = [wp1,wp2,wp3,wp4,wp5];
    return items;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = UiUtil.getDeviceWidth(context);
    debugPrint(position.toString());
    return GestureDetector(
      child: Stack(
          children: _changePosition(position)
              .map((position){
            return Positioned(
                top: position.top,
                left: position.left,
                child: Card(
                  child: Container(
                    width: position.width,
                    height: position.height,
                  ),
                  elevation: 10,
                  color: position.color,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                )
            );
          }).toList()
      ),
//      onPanUpdate: (DragUpdateDetails e){
//        setState(() {
//          this.position = position - (e.delta.dx/this.width);
//        });
//      },
      onHorizontalDragUpdate: (DragUpdateDetails e){
        setState(() {
          this.position = position - (e.delta.dx/this.width);
        });
      },
      onPanEnd: (DragEndDetails e){
        double dy = e.velocity.pixelsPerSecond.dy;
        print(dy);
        //_startAutoScroll(position.round().toDouble());
      },
    );
  }

  _startAutoScroll(double end) {
    debugPrint('动画${position} - - ${end}');
    _animation = Tween(begin: position,end: end)
      .animate(_animationController)
      ..addListener((){
        setState(() {
          position = _animation.value;
        });
      });
    _animationController.forward(from: position);
  }

}