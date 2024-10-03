import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/feed_bloc.dart';
import '../../bloc/category_bloc.dart';
import '../../models/data_model.dart';

class StoryReaderScreen extends StatefulWidget {
  final String storyId;
  const StoryReaderScreen({super.key, required this.storyId});

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen> {
     final fBloc = FeedBloc();

  @override
  void initState() {
    super.initState();
    fBloc.add(StoryReaderInitialLoadEvent(storyId: widget.storyId));
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: fBloc,
        builder: (context,state){
      switch(state.runtimeType){
        case StoryReaderInitialState: {
          var s = state as StoryReaderInitialState;
          return getSuccessUI(s.story);
        }
        default: return const SizedBox();
      }
    });
  }

  Widget getSuccessUI(StoryModel story){
   return Scaffold(
     appBar: AppBar(
         centerTitle: true,
         title:    Text(story.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
         bottom: PreferredSize(preferredSize: const Size.fromHeight(20),child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text('Written by ${story.author}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16)),
         ),
         )),
     body:  SingleChildScrollView(
       child: Column(
         children: [
           Container(width: double.infinity,
               height: 300,
               decoration: BoxDecoration(
                 color: Colors.blueGrey[50],
                 border: Border.all(
                   color: Colors.black,
                   width: 4,
                 ),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black26,
                     blurRadius: 10,
                     offset: Offset(4, 4),
                   ),
                 ],),
               child:Image.network(story.image,fit: BoxFit.cover)),
           Text(story.story
               ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),
               softWrap: true)

         ],
       ),
     ),
   );

  }

}
