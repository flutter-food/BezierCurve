# BezierCurve

> 百度百科: 贝塞尔曲线(Bézier curve)，又称贝兹曲线或贝济埃曲线，是应用于二维图形应用程序的数学曲线。一般的矢量图形软件通过它来精确画出曲线，贝兹曲线由线段与节点组成，节点是可拖动的支点，线段像可伸缩的皮筋，我们在绘图工具上看到的钢笔工具就是来做这种矢量曲线的。贝塞尔曲线是计算机图形学中相当重要的参数曲线，在一些比较成熟的位图软件中也有贝塞尔曲线工具，如PhotoShop等。在Flash4中还没有完整的曲线工具，而在Flash5里面已经提供出贝塞尔曲线工具。


##### 设计图效果--[设计图地址](https://weibo.com/1773655610/CzUai6Gid?type=comment#_rnd1562323657853)

![](https://user-gold-cdn.xitu.io/2019/7/5/16bc1bde12c1afa6?w=240&h=180&f=gif&s=922629)

##### 开发效果图


![](https://user-gold-cdn.xitu.io/2019/7/5/16bc1c05d2aa58f1)

![](https://user-gold-cdn.xitu.io/2019/7/5/16bc1bffabc153d7?w=240&h=400&f=gif&s=50563)



### 贝塞尔曲线画圆

![](https://user-gold-cdn.xitu.io/2019/7/5/16bc1d04b91a5690?w=400&h=400&f=png&s=13687)

如图当画圆时系数M约等于0.55228475，绘制时调用cubicTo(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y)进行绘制，绘制时以圆心为圆点，x轴、y轴为线划分成4分，进行绘制。

### [分享一个贝塞尔曲线在线演示网站](https://cubic-bezier.com/#0,.97,0,.98)

### [项目地址](https://github.com/flutter-food/BezierCurve)

### 后续
> 在UI中国上看到了一个不错的设计，里面也涉及贝塞尔曲线[全手势操作灯的demo](https://www.ui.cn/detail/102368.html),这里的贝塞尔曲线p2、p4的Y轴向中间做一个伸缩就可以。

![](https://user-gold-cdn.xitu.io/2019/7/5/16bc1c2cf46335a0?w=600&h=1000&f=gif&s=1807606)

