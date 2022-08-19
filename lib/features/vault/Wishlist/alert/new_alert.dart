import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class TopBarPage extends StatefulWidget {
  @override
  createState() => TopBarPageState();
}


class TopBarPageState extends State<TopBarPage> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        bottom:  TabBar(
          tabs: const <Widget>[
            Tab(
              text: ("Mint"),
            ),
            Tab(
              text: ("Price"),
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new Center(child: new Text('Google',style: TextStyle(fontSize: 20,),)),
          new Center(child: new Text('Facebook',style: TextStyle(fontSize: 20,),)),
        ],
      ),
    );
  }


}