import 'package:bezier_curve_master/widget/bessel1_view.dart';
import 'package:flutter/material.dart';
import 'package:bezier_curve_master/utils/ui_util.dart';

class IndicatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      appBar: AppBar(
//        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
//        title: Text("指示器"),
//      ),
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

class _IndicatorState extends State<_IndicatorView> {

  double curPosition = 0;
  int preInteger = 0;
  double radius = 30;
  bool isToRight = true;

  PageController _pageController;
  List<Color> colors = [
    Colors.red,
    Colors.deepOrange,
    Colors.amber,
    Colors.blue,
    Colors.deepPurpleAccent
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _pageController.addListener((){
      curPosition = _pageController.page;
      if (curPosition.toInt() == curPosition) {
        preInteger = curPosition.toInt();
      } else if (curPosition > preInteger) {
        isToRight = true;
      } else {
        isToRight = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    double percent;
    if (isToRight) {
      percent = curPosition - curPosition.toInt();
    } else {
      percent =  1 - curPosition + curPosition.toInt();
    }

    // 0.32092592592592606、0.15166666666666684

    double offsetPercent;
    if (isToRight) {
      if (percent <= 0.8) {
        offsetPercent = curPosition.toInt() + percent/0.8;
      } else {
        offsetPercent = curPosition.ceil().toDouble();
      }
    } else {
      if (percent <= 0.8) {
        offsetPercent = curPosition.ceil() - percent/0.8;
      } else {
        offsetPercent = curPosition.toInt().toDouble();
      }
    }

    double deviceWidth = UiUtil.getDeviceWidth(context);
    double offSetX = deviceWidth*0.1+(deviceWidth - radius*2 - deviceWidth*0.2)*offsetPercent/4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 20),
          height: 260,
          child: PageView.builder(
            itemBuilder: (context,index){
              return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 8.0,
                  ),
                  child: Card(
                    elevation: 10,
                    color: colors[index],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
              );
            },
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            reverse: false,
            controller: _pageController,
            physics: const PageScrollPhysics(parent: const BouncingScrollPhysics()),
            // onPageChanged: (index){},
          ),
        ),
        Transform.translate(
            offset: Offset(offSetX, 0),
            child: CustomPaint(
              painter: BesselView(
                  radius: radius,
                  percent: percent,
                  isToRight: isToRight,
                  color: HSVColor.lerp(
                      HSVColor.fromColor(colors[preInteger > curPosition ? curPosition.toInt() : preInteger]),
                      HSVColor.fromColor(colors[preInteger > curPosition ? preInteger :  curPosition.ceil()]),
                      percent
                  ).toColor()
              ),
            ),
        ),
      ],
    );
  }



}