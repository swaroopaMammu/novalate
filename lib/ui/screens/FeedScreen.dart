import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/bloc/feed_bloc.dart';
import 'package:novalate/utils/NavigationConstants.dart';

import '../widgets/image_card.dart';
import '../widgets/list_item_card_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key, required this.feedBloc});
  final FeedBloc feedBloc;
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {


  @override
  void initState() {
    super.initState();
    widget.feedBloc.add(FeedsInitialLoadEvent(searchQ:''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc,FeedState>(
       bloc: widget.feedBloc,
        listenWhen: (prev,curr) => curr is FeedActionState,
        buildWhen: (prev,current) => current is !FeedActionState,
        builder: (context,state){
           switch(state.runtimeType){
             case FeedInitialLoadSuccessState : return getSuccessUI(state as FeedInitialLoadSuccessState);
             case FeedInitialEmptyState : return getEmptyListScreen();
             default : return SizedBox();
           }
        },
        listener: (BuildContext context, FeedState state) {
               if(state is FeedClickSuccessState){
                 context.push('/${NavigationConstants.STORY_READER}/${state.storyId}${NavigationConstants.FEEDS}');
               }
        }
    );
  }

  Widget getEmptyListScreen(){
    return   Center(
      child: Text("No Drafts available"),
    );
  }

  Widget getSuccessUI(FeedInitialLoadSuccessState state){
    return ListView.separated(
      itemCount: state.storyList.length,
      itemBuilder: (context, index) {
        return  GestureDetector(
          onTap: (){
            widget.feedBloc.add(FeedsClickEvent(storyId:state.storyList[index].storyId ));
          },
          child: ListItemCardWidget(childWidgetList: [
            BorderedImageCard(imgUrl:state.storyList[index].image,height: 200,width: double.infinity),
            Text(state.storyList[index].title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
            Text(state.storyList[index].author,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
            Text(state.storyList[index].category,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300))
          ])
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
    );
  }
}
