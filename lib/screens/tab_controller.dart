import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_c8_friday/screens/home_screen/cubit/cubit.dart';
import 'package:news_app_c8_friday/screens/home_screen/cubit/states.dart';
import 'package:news_app_c8_friday/screens/tab_item.dart';
import 'package:news_app_c8_friday/shared/remote/api_manager.dart';

import '../models/Sources.dart';
import 'news_item.dart';

class TabControllerScreen extends StatelessWidget {
  List<Sources> sources;

  TabControllerScreen(this.sources);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            DefaultTabController(
                length: sources.length,
                child: Column(
                  children: [
                    TabBar(
                        onTap: (index) {
                          HomeCubit.get(context).changeSource(index);
                        },
                        indicatorColor: Colors.transparent,
                        isScrollable: true,
                        labelColor: Colors.blue,
                        tabs: sources
                            .map((source) => TabItem(
                                  source: source,
                                  isSelected:
                                      HomeCubit.get(context).selectedIndex ==
                                          sources.indexOf(source),
                                ))
                            .toList())
                  ],
                )),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return NewsItem(HomeCubit.get(context).news[index]);
                },
                itemCount: HomeCubit.get(context).news.length,
              ),
            ),
            // FutureBuilder(
            //   future:
            //   ApiManager.getNewsData(widget.sources[selectedIndex].id ?? ""),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: CircularProgressIndicator());
            //     }
            //     if (snapshot.hasError) {
            //       return Center(child: Text("something went wrong"));
            //     }
            //     if (snapshot.data?.status != "ok") {
            //       return Center(child: Text(snapshot.data?.message ?? ""));
            //     }
            //     var news = snapshot.data?.articles ?? [];
            //
            //     return Expanded(
            //       child: ListView.builder(
            //         itemBuilder: (context, index) {
            //           return NewsItem(news[index]);
            //         },
            //         itemCount: news.length,
            //       ),
            //     );
            //   },
            // )
          ],
        );
      },
    );
  }
}
