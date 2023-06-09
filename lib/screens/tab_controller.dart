import 'package:flutter/material.dart';
import 'package:news_app_c8_friday/screens/tab_item.dart';
import 'package:news_app_c8_friday/shared/remote/api_manager.dart';

import '../models/Sources.dart';
import 'news_item.dart';

class TabControllerScreen extends StatefulWidget {
  List<Sources> sources;

  TabControllerScreen(this.sources);

  @override
  State<TabControllerScreen> createState() => _TabControllerScreenState();
}

class _TabControllerScreenState extends State<TabControllerScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: widget.sources.length,
            child: Column(
              children: [
                TabBar(
                    onTap: (index) {
                      selectedIndex = index;
                      setState(() {});
                    },
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    labelColor: Colors.blue,
                    tabs: widget.sources
                        .map((source) => TabItem(
                              source: source,
                              isSelected: selectedIndex ==
                                  widget.sources.indexOf(source),
                            ))
                        .toList())
              ],
            )),
        FutureBuilder(
          future:
              ApiManager.getNewsData(widget.sources[selectedIndex].id ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("something went wrong"));
            }
            if (snapshot.data?.status != "ok") {
              return Center(child: Text(snapshot.data?.message ?? ""));
            }
            var news = snapshot.data?.articles ?? [];

            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return NewsItem(news[index]);
                },
                itemCount: news.length,
              ),
            );
          },
        )
      ],
    );
  }
}
