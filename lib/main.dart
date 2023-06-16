import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app_c8_friday/layout/home_layout.dart';
import 'package:news_app_c8_friday/shared/styles/my_theme.dart';

import 'cubit_changes.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyThemeData.lightTheme,
      routes: {
        HomeLayout.routeName:(context)=>HomeLayout()
      },

      initialRoute: HomeLayout.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}

