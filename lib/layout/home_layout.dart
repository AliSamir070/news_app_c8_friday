import 'package:flutter/material.dart';
import 'package:news_app_c8_friday/models/category_model.dart';
import 'package:news_app_c8_friday/screens/categories_scrreen.dart';

import '../models/SourceResponse.dart';
import '../models/Sources.dart';
import '../screens/drawer_widget.dart';
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

      drawer: DrawerWidget(onDrawerClicked),
      appBar: AppBar(

        title: Text(categoryModel==null?"News App":categoryModel!.name),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          )
        ),
      ),
      body:categoryModel==null?
      CategoriesScreen(changeCategory)
      :HomeScreen(categoryModel!),
    );
  }

  CategoryModel? categoryModel=null;
  void onDrawerClicked(number){
    if(number==DrawerWidget.CATEGORIES){
      categoryModel=null;
    }else if(number==DrawerWidget.SETTINGS){
      // open settings tab
    }
    setState(() {
      Navigator.pop(context);
    });
  }
  void changeCategory(category){
    categoryModel=category;
    setState(() {

    });
  }
}
