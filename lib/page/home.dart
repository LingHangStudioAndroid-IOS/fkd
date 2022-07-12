import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '主页',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          height: 50,
          child: Text.rich(TextSpan(
              text: '武科大助手',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              children: <TextSpan>[
                TextSpan(
                    text: "  wust helper",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal))
              ])),
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(45)),
          ),
          height: 250,
          padding: EdgeInsets.all(10),
          child: BannerHomepage(),
        ),
        Container(
          padding: EdgeInsets.all(10),
          height: 40,
          child: Text(
            '热门功能',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          height: 500,
          color: Colors.white,
          child: method(),
        )
      ],
    );
  }
}

class BannerHomepage extends StatefulWidget {
  final bool isTitle;

  BannerHomepage({this.isTitle = true});

  @override
  State<StatefulWidget> createState() {
    return _BannerHomepageState();
  }
}

class _BannerHomepageState extends State<BannerHomepage> {
  //轮播图 PageView 使用的控制器
  late PageController _pageController;
  //定时器自动轮播
  late Timer _timer;
  //本地资源图片
  List<String> imageList = [
    'assets/images/1.jpeg',
    'assets/images/3.jpeg',
    'assets/images/2.jpeg'
  ];

  //当前显示的索引
  int currentIndex = 1000;

  @override
  void initState() {
    super.initState();
    //初始化控制器
    // initialPage 为初始化显示的子Item
    _pageController = new PageController(initialPage: currentIndex);

    ///当前页面绘制完第一帧后回调
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      startTimer();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void startTimer() {
    //间隔两秒时间
    _timer = new Timer.periodic(Duration(milliseconds: 2000), (value) {
      print("定时器");
      currentIndex++;
      //触发轮播切换
      _pageController.animateToPage(currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
      //刷新
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: buildBanner(),
      ),
    );
  }

  Widget buildBanner() {
    return Container(
      // height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          //轮播图片
          buildBannerWidget(),
          //指示器
          buildTipsWidget(),
        ],
      ),
    );
  }

  buildBannerWidget() {
    //懒加载方式构建
    return PageView.builder(
      //构建每一个子Item的布局
      itemBuilder: (BuildContext context, int index) {
        return buildPageViewItemWidget(index);
      },
      //控制器
      controller: _pageController,
      //轮播个数 无限轮播 ??
      itemCount: imageList.length * 10000,
      //PageView滑动时回调
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }

  //轮播显示图片
  buildPageViewItemWidget(int index) {
    return Image.asset(
      imageList[index % imageList.length],
      fit: BoxFit.fill,
    );
  }

  //指示器
  buildTipsWidget() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Container(
        //内边距
        padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
        //圆角边框
        decoration: BoxDecoration(
            //背景
            color: Colors.white,
            //边框圆角
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child:
            Text("${currentIndex % imageList.length + 1}/${imageList.length}"),
      ),
    );
  }
}

class method extends StatelessWidget {
  const method({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // Row(
      //   children: <Widget>[
      //     // ignore: deprecated_member_use
      //   ],
      // ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(45)),
            ),
            height: 170,
            child: RaisedButton(
              color: Colors.lightGreenAccent,
              textColor: Colors.green,
              child: Text.rich(TextSpan(
                  text: '成绩查询',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  children: <TextSpan>[
                    TextSpan(
                        text: "",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal)),
                  ])),
              onPressed: () {
                print('object');
              },
            ),
          )),
          Container(
            height: 200,
            child: RaisedButton(
              color: Colors.purple,
              textColor: Colors.purple,
              child: Text.rich(TextSpan(
                  text: '考试提醒',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  children: <TextSpan>[
                    TextSpan(
                        text: "",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal)),
                  ])),
              onPressed: () {
                print("object1");
              },
            ),
          ),
        ],
      )
    ]);
  }
}
