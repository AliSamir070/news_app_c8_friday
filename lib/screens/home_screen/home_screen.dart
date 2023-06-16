import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_c8_friday/models/category_model.dart';
import 'package:news_app_c8_friday/screens/home_screen/cubit/cubit.dart';
import 'package:news_app_c8_friday/screens/home_screen/cubit/states.dart';
import 'package:news_app_c8_friday/screens/tab_controller.dart';
import 'package:news_app_c8_friday/screens/tab_item.dart';

import '../../models/SourceResponse.dart';
import '../../models/Sources.dart';
import '../../shared/remote/api_manager.dart';

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
      child: BlocProvider(
          create: (context) => HomeCubit()..getSources(widget.categoryModel.id),
          child: BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {
              if (state is HomeLoadingState) {
                showDialog(
                  context: context,
                  builder: (context) =>
                      Center(child: CircularProgressIndicator()),
                );
              } else if (state is HomeGetSourcesSuccessState) {
                HomeCubit.get(context).getNewsData();
              }else if (state is ChangeSourceState) {
                HomeCubit.get(context).getNewsData();
              } else if (state is HomeGetNewsSuccessState) {
                Navigator.pop(context);
              } else if (state is HomeGetNewsErrorState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text(state.error),
                    actions: [
                      TextButton(
                          onPressed: () {
                            HomeCubit.get(context)
                                .getSources(widget.categoryModel.id);
                          },
                          child: Text("Try Again"))
                    ],
                  ),
                );
              } else if (state is HomeGetSourcesErrorState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text(state.error),
                    actions: [
                      TextButton(
                          onPressed: () {
                            HomeCubit.get(context)
                                .getSources(widget.categoryModel.id);
                          },
                          child: Text("Try Again"))
                    ],
                  ),
                );
              }
            },
            builder: (context, state) {
              return TabControllerScreen(HomeCubit.get(context).sources);
            },
          )),
      // child: FutureBuilder<SourceResponse?>(
      //     future: ApiManager.getSources(widget.categoryModel.id),
      //     builder: (context , snapshot){
      //       if(snapshot.hasError){
      //         return Center(
      //           child: Column(
      //             children: [
      //               Text("Something went wrong"),
      //               TextButton(onPressed: (){
      //                 setState(() {
      //
      //                 });
      //               }, child: Text("try again"))
      //             ],
      //           ),
      //         );
      //       }else if(snapshot.connectionState == ConnectionState.waiting){
      //         return Center(child: CircularProgressIndicator(),);
      //       }else if(snapshot.data!.status == "error"){
      //         return Center(
      //           child: Column(
      //             children: [
      //               Text(snapshot.data?.message??""),
      //               TextButton(onPressed: (){
      //                 setState(() {
      //
      //                 });
      //               }, child: Text("try again"))
      //             ],
      //           ),
      //         );
      //       }
      //       List<Sources> sources = snapshot.data?.sources??[];
      //       return TabControllerScreen(sources);
      //     }
      // ),
    );
  }
}
