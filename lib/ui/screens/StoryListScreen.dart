import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/utils/NavigationConstants.dart';

class StoryListScreen extends StatelessWidget {
  const StoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thriller Stories"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: 20,
        itemBuilder: (context, index) {
          return  GestureDetector(
            onTap: (){
              context.pushNamed(NavigationConstants.STORY_READER);
            },
            child: Card(
              elevation: 4.0,  // Adds shadow for the card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),  // Rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Item $index',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
      )
    );
  }
}
