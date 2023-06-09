import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  Function onDrawerClick;
  DrawerWidget(this.onDrawerClick);

  static int CATEGORIES=1;
  static int SETTINGS=2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width*.7,
       color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(40),
                color: Colors.green,
                child: Center(
                  child: Text("News App",style: Theme.of(context)
                    .textTheme.bodyLarge,),
                )),
            InkWell(
              onTap: () {
                onDrawerClick(CATEGORIES);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Categories"),
              ),
            ),
            InkWell(
              onTap: () {
                onDrawerClick(SETTINGS);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Settings"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
