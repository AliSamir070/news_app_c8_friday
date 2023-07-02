import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../screens/categories.dart';
import '../screens/drawer_widget.dart';
import '../screens/news_Screen.dart';
import '../screens/widgets/news_item.dart';
import '../shared/network/remote/api_manager.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: isSearch?null:DrawerWidget(onDrawerClicked),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22),
            )),
        backgroundColor: Color(0xFF39A552),
        title: isSearch?TextField(
          controller: controller,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40)
            ),
            prefixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    controller.clear();
                    isSearch = false;
                  });
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.green,
                )),
            suffixIcon: IconButton(
                onPressed: (){
                  setState(() {

                  });
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.green,
                )),
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.grey
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: "Search..."
          ),
        ):Text(categoryModel == null ? "News App" : categoryModel!.name),
        actions: !isSearch?categoryModel !=null?[
          IconButton(
              onPressed: (){
                //showSearch(context: context, delegate: NewsSearchDelegate());
                setState(() {
                  isSearch = true;
                });
              },
              iconSize: 25,
              icon: Icon(
                  Icons.search,
                color: Colors.white,

              )
          )
        ]:null:null,
      ),
      body: categoryModel == null
          ? CategoriesScreen(onCategorySelected)
          : NewsScreen(categoryModel!,controller.text),
    );
  }

  CategoryModel? categoryModel = null;

  void onDrawerClicked(number) {
    if (number == DrawerWidget.CATEGORY) {
      categoryModel = null;
    } else if (number == DrawerWidget.SETTINGS) {
      // open settings tab
    }
    setState(() {
      Navigator.pop(context);
    });
  }

  void onCategorySelected(category) {
    categoryModel = category;
    setState(() {});
  }
}

class NewsSearchDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (){
            query = "";
          },
          iconSize: 20,
          icon: Icon(
            Icons.clear,
            color: Colors.green,
          )
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        iconSize: 20,
        icon: Icon(
          Icons.arrow_back,
          color: Colors.green,
        )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future:
      ApiManager.getNewsData(q: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Column(
            children: [
              Text("something went wrong"),
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
        var newsData = snapshot.data?.articles ?? [];
        return ListView.builder(
          itemBuilder: (context, index) {
            return NewsItem(newsData[index]);
          },
          itemCount: newsData.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Suggestions"),);
  }

}
