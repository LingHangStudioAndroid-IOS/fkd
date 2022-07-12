import 'package:flutter/material.dart';
import 'package:truedemo/page/home.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List _pageList = [
    HomePage(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('武汉科技大学'),
      ),
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.greenAccent,
        backgroundColor: Colors.white,
        currentIndex: this._currentIndex,
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页', style: TextStyle(color: Colors.grey)),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text('课程', style: TextStyle(color: Colors.grey))),
          BottomNavigationBarItem(
              icon: Icon(Icons.volunteer_activism),
              title: Text('志愿者', style: TextStyle(color: Colors.grey))),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('个人', style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }
}
