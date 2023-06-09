import 'package:flutter/material.dart';
import 'package:news_app_c8_friday/models/category_model.dart';

class CategoryItem extends StatelessWidget {
 CategoryModel categoryModel;
 int index;
 CategoryItem(this.categoryModel,this.index);

  @override
  Widget build(BuildContext context) {
    return Container(

     decoration: BoxDecoration(
      color: categoryModel.color
          ,borderRadius: BorderRadius.only(
      topRight:Radius.circular(30) ,topLeft: Radius.circular(30),
      bottomLeft: index.isEven?Radius.circular(30):Radius.zero,
         bottomRight: index.isOdd?Radius.circular(30):Radius.zero
     )
     ),
      child: Column(
       children: [
        Image.asset(categoryModel.image,
        height: 120,),
        Expanded(child: Center(child: Text(categoryModel.name,style: Theme
         .of(context).textTheme.bodyLarge!.copyWith(
         color: Colors.white,
         fontSize: 18
        ),)))
       ],
      ),
    );
  }
}
