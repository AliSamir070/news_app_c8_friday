import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_c8_friday/layout/web_screen.dart';
import 'package:news_app_c8_friday/models/NewsResponse.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "DetailsScreen";

  @override
  Widget build(BuildContext context) {
    var article = ModalRoute.of(context)?.settings.arguments as Articles;
    var date = DateTime.parse(article.publishedAt??"");
    return Scaffold(
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
      title: Text(article.title??""),
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              CachedNetworkImage(
                  imageUrl: article.urlToImage??"",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                placeholder: (context,url)=>Center(child: CircularProgressIndicator(),),
                errorWidget: (context , url , provider)=>Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                article.source?.name??"",
                style: TextStyle(fontSize: 13, color: Color(0xff707070)),
              ),
              SizedBox(height: 10,),
              Text(
                article.title??"",
                style: TextStyle(fontSize: 16, color: Colors.black45,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15,),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${date.year} - ${date.month} - ${date.day}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  article.description??"",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38
                  ),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, WebViewScreen.routeName,arguments: article);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "View this article",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(width: 10,),
                    Icon(
                      Icons.arrow_right,
                      color: Colors.black,
                      size: 30,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
