import 'package:flutter/material.dart';
import 'package:novalate/models/data_model.dart';

class StoriesListWidget extends StatelessWidget {

  final List<StoryModel> storyList;
  final void Function(int index) onTap;
  final void Function(int index) onDismiss;
   StoriesListWidget({super.key,required this.storyList,required this.onTap,required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: storyList.length,
      itemBuilder: (context, index) {
        return  Dismissible(
            key: Key(storyList[index].storyId),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              onDismiss(index);
            },
            background: Container(
                width: double.infinity,
                color: Colors.red, // Background color when swiped
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            child: GestureDetector(
              onTap: (){
                onTap(index);
              },
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 4.0,  // Adds shadow for the card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),  // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "${storyList[index].title}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }
}