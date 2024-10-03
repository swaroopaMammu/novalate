import 'package:flutter/material.dart';

class ListItemCardWidget extends StatelessWidget {
  const ListItemCardWidget({super.key, required this.childWidgetList});
  final List<Widget> childWidgetList;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,  // Adds shadow for the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),  // Rounded corners
      ),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: childWidgetList,
          )
      ),
    );
  }
}
