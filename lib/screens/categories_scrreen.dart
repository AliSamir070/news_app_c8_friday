import 'package:flutter/material.dart';
import 'package:news_app_c8_friday/models/category_model.dart';

import 'categoryItem.dart';

class CategoriesScreen extends StatelessWidget {
  var categories = CategoryModel.getCategories();

  Function onCategoryClick;
  CategoriesScreen(this.onCategoryClick);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Pick your category of interset",style:
        Theme.of(context).textTheme.bodyLarge,),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onCategoryClick(categories[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoryItem(categories[index],index),
                ),
              );
            },
            itemCount: categories.length,
          ),
        )
      ],
    );
  }
}
