import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/bloc/feed_bloc.dart';
import 'package:novalate/utils/NavigationConstants.dart';

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
                 context.push('/${NavigationConstants.STORY_READER}/${state.storyId}');
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
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        border: Border.all(
                          color: Colors.black,
                          width: 4,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(4, 4),
                          ),
                        ],),
                      child:Image.network(state.storyList[index].image,fit: BoxFit.cover)),
                  Text(state.storyList[index].title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  Text(state.storyList[index].author,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                  Text(state.storyList[index].category,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300))
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
    );
  }
}
