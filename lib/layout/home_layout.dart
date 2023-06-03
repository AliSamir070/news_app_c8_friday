import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/pattern copy.jpg'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: Container(color: Colors.red, width: 180),
        ),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(103, 172, 92, 0.8),
          toolbarHeight: 100,
          title: Text("News App"),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          )),
        ),
        body: HomeScreen(),
      ),
    );
  }
}
