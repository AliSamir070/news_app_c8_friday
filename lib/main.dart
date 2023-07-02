import 'package:flutter/material.dart';

import 'layout/details_screen.dart';
import 'layout/home.dart';
import 'layout/web_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        DetailsScreen.routeName:(context)=>DetailsScreen(),
        WebViewScreen.routeName:(context)=>WebViewScreen()
      },
    );
  }
}
