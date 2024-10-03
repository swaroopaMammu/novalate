import 'package:flutter/material.dart';
import 'package:novalate/models/data_model.dart';

import 'image_card.dart';
import 'list_item_card_widget.dart';

class StoriesListWidget extends StatelessWidget {

  final List<StoryModel> storyList;
  final void Function(int index) onTap;
  final void Function(int index) onDismiss;
  final bool showImage;
   StoriesListWidget({super.key,required this.storyList,required this.onTap,required this.onDismiss, required this.showImage});

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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
            child: GestureDetector(
              onTap: (){
                onTap(index);
              },
              child: SizedBox(
              width: double.infinity,
              child:   ListItemCardWidget(childWidgetList: [if(storyList[index].image.isNotEmpty && showImage) BorderedImageCard(imgUrl:storyList[index].image,height: 200,width: double.infinity),
                Text(storyList[index].title, style: const TextStyle(fontSize: 18))],)
              )
            ),
          );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }
}