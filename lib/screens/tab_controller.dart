import 'package:flutter/material.dart';
import 'package:news_app_c8_friday/screens/tab_item.dart';

import '../models/Sources.dart';

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
    return DefaultTabController(
        length: widget.sources.length,
        child: Column(
          children: [
            TabBar(
                onTap: (index){
                  selectedIndex = index;
                  setState(() {

                  });
                },
                indicatorColor: Colors.transparent,
                isScrollable: true,
                labelColor: Colors.blue,
                tabs: widget.sources.map((source) => TabItem(source: source,isSelected: selectedIndex==widget.sources.indexOf(source),)).toList()
            )
          ],
        )
    );
  }
}
