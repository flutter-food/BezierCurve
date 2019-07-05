import 'package:flutter/material.dart';
import 'package:bezier_curve_master/page/base_ball_page.dart';
import 'package:bezier_curve_master/utils/ui_util.dart';
import 'package:bezier_curve_master/page/indicator_self_page.dart';
import 'package:bezier_curve_master/page/indicator_page.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {

  void _routeToPage(BuildContext context,Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        return page;
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("贝塞尔曲线"),),
        body: Builder(
            builder: (context) {
              return Container(
                width: UiUtil.getDeviceWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    OutlineButton(
                        child: Text(
                          "基础波浪球",
                          style: TextStyle(fontSize: 20,color: Colors.black),
                        ),
                        onPressed: () => _routeToPage(context,BaseBallPage())
                    ),
                    OutlineButton(
                        child: Text(
                          "指示器",
                          style: TextStyle(fontSize: 20,color: Colors.black),
                        ),
                        onPressed: () => _routeToPage(context,IndicatorSelfPage())
                    ),
                    OutlineButton(
                        child: Text(
                          "指示器1",
                          style: TextStyle(fontSize: 20,color: Colors.black),
                        ),
                        onPressed: () => _routeToPage(context,IndicatorPage())
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
