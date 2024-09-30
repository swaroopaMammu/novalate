import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/utils/NavigationConstants.dart';

import '../../bloc/category_bloc.dart';
import '../widgets/stories_list_widget.dart';

class StoryListScreen extends StatefulWidget {
  final String category;
  const StoryListScreen({super.key, required this.category});

  @override
  State<StoryListScreen> createState() => _StoryListScreenState();
}

class _StoryListScreenState extends State<StoryListScreen> {
  final storyBloc = CategoryBloc();


  @override
  void initState() {
    super.initState();
    storyBloc.add(StoryListInitialLoadEvent(category: widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category} Stories"),
        centerTitle: true,
      ),
      body: BlocConsumer(
        bloc: storyBloc,
          listenWhen: (prev,curr) => curr is CategoryActionState,
          buildWhen: (prev,current) => current is !CategoryActionState,
          builder: (context,state){
            switch(state.runtimeType){
              case StoryListLoadSuccess: {
                final s = state as StoryListLoadSuccess;
                return    StoriesListWidget(storyList:s.storyList,onTap: (int i){
                  storyBloc.add(StoryClickEvent(storyId: s.storyList[i].storyId));
                },onDismiss: (int i){});
              }
              case StoryListLoadEmpty:{
                return Center(
                child: Text("No Stories available"),
            );
              }
              default: SizedBox();
            }
            return Container();
          },
          listener: (BuildContext bContext, CategoryState state ){
                if(state is StoryClickSuccess){
                  context.push('/${NavigationConstants.STORY_READER}/${state.storyId}');
                }
          })
    );
  }
}
