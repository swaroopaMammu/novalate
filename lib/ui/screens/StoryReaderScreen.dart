import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/feed_bloc.dart';
import '../../bloc/category_bloc.dart';
import '../../models/data_model.dart';
import '../widgets/image_card.dart';

class StoryReaderScreen extends StatefulWidget {
  final String storyId;
  final Bloc bloc;
  const StoryReaderScreen({super.key, required this.storyId,required this.bloc});

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen> {

  @override
  void initState() {
    super.initState();
    if(widget.bloc is CategoryBloc){
      widget.bloc.add(StoryInitialLoadEvent(storyId: widget.storyId));
    }else{
      widget.bloc.add(StoryReaderInitialLoadEvent(storyId: widget.storyId));
    }

  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.bloc,
        builder: (context,state){
      switch(state.runtimeType){
        case StoryReaderInitialState: {
          var s = state as StoryReaderInitialState;
          return getSuccessUI(s.story);
        }
        case StoryInitialState : {
          var s = state as StoryInitialState;
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
       child: Padding(
         padding: const EdgeInsets.all(5.0),
         child: Column(
           children: [
             BorderedImageCard(imgUrl:story.image, width: double.infinity, height: 300),
             SizedBox(height:10),
             Text("${story.story}"
                 ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),
                 softWrap: true)
           ],
         ),
       ),
     ),
   );

  }

}
