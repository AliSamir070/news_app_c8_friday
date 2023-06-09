import 'package:flutter/material.dart';

import '../models/Sources.dart';

class TabItem extends StatelessWidget {
  Sources source;
  bool isSelected;
  TabItem({required this.source , this.isSelected = false});
  @override
  Widget build(BuildContext context) {
    return Container(
     padding: EdgeInsets.symmetric(vertical: 4,horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected?Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green)
      ),
      child: Text(
        source.name??"",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isSelected?Colors.white:Colors.green
        ),
      ),
    );
  }
}
