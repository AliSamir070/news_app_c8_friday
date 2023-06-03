import 'package:flutter/material.dart';

import '../models/SourceResponse.dart';
import '../models/Sources.dart';
import '../screens/home_screen.dart';
import '../shared/remote/api_manager.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(color: Colors.red,width: 180),
      ),
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text("News App"),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          )
        ),
      ),
      body: HomeScreen(),
    );
  }
}
