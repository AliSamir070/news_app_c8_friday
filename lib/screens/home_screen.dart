import 'package:flutter/material.dart';
import 'package:news_app_c8_friday/models/category_model.dart';
import 'package:news_app_c8_friday/screens/tab_controller.dart';
import 'package:news_app_c8_friday/screens/tab_item.dart';

import '../models/SourceResponse.dart';
import '../models/Sources.dart';
import '../shared/remote/api_manager.dart';

class HomeScreen extends StatefulWidget {

  CategoryModel categoryModel;
  HomeScreen(this.categoryModel);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: FutureBuilder<SourceResponse?>(
          future: ApiManager.getSources(widget.categoryModel.id),
          builder: (context , snapshot){
            if(snapshot.hasError){
              return Center(
                child: Column(
                  children: [
                    Text("Something went wrong"),
                    TextButton(onPressed: (){
                      setState(() {

                      });
                    }, child: Text("try again"))
                  ],
                ),
              );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.data!.status == "error"){
              return Center(
                child: Column(
                  children: [
                    Text(snapshot.data?.message??""),
                    TextButton(onPressed: (){
                      setState(() {

                      });
                    }, child: Text("try again"))
                  ],
                ),
              );
            }
            List<Sources> sources = snapshot.data?.sources??[];
            return TabControllerScreen(sources);
          }
      ),
    );
  }
}
