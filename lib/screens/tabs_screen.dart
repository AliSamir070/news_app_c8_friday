import 'package:flutter/material.dart';
import 'package:news_app_c8_friday/screens/widgets/news_item.dart';
import 'package:news_app_c8_friday/screens/widgets/source_item.dart';


import '../models/NewsResponse.dart';
import '../models/SourcesResponse.dart';
import '../shared/network/remote/api_manager.dart';

class TabsScreen extends StatefulWidget {
  List<Sources> sources;
  String query;
  TabsScreen(this.sources ,this.query);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;
  int page = 1;
  late ScrollController scrollController;
  List<Articles> articles = [];
  late Future getNews;
  @override
  void initState() {
    getNews = ApiManager.getNewsData(sourceId: widget.sources[selectedIndex].id ?? "",q:widget.query ,page: page);
    scrollController = ScrollController();
    scrollController.addListener(() {
      if(scrollController.position.atEdge){
        if(scrollController.position.pixels!=0){
          ++page;
          getNews = ApiManager.getNewsData(sourceId: widget.sources[selectedIndex].id ?? "",q:widget.query ,page: page);
          setState(() {

          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: widget.sources.length,
            child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                onTap: (value) {
                  selectedIndex = value;
                  setState(() {});
                },
                tabs: widget.sources.map((source) {
                  return Tab(
                    child: SourceItem(source,
                        widget.sources.indexOf(source) == selectedIndex),
                  );
                }).toList())),
        FutureBuilder(
          future: getNews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Column(
                children: [
                  Text(snapshot.error!.toString()),
                  TextButton(
                    onPressed: () {},
                    child: Text("Try Again"),
                  )
                ],
              );
            }

            if (snapshot.data?.status != "ok") {
              return Column(
                children: [
                  Text(snapshot.data?.message ?? ""),
                  TextButton(
                    onPressed: () {},
                    child: Text("Try Again"),
                  )
                ],
              );
            }
            articles.addAll(snapshot.data?.articles??[]);
            return Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  return NewsItem(articles[index]);
                },
                itemCount: articles.length,
              ),
            );
          },
        )
      ],
    );
  }
}
