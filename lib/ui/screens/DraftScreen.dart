import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/utils/NavigationConstants.dart';

import '../../bloc/drafts_bloc.dart';
import '../widgets/stories_list_widget.dart';

class DraftScreen extends StatefulWidget {
  const DraftScreen({super.key,required this.bloc});
  final DraftsBloc bloc;
  @override
  State<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends State<DraftScreen> {

  String storyId = "hh";

  @override
  void initState() {
    super.initState();
   widget.bloc.add(DraftsListLoadEvent(searchQ:""));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DraftsBloc,DraftsState>(
        bloc: widget.bloc,
        listenWhen: (prev,curr) => curr is DraftsActionState,
        buildWhen: (prev,current) => current is !DraftsActionState,
        builder: (context,state){
          switch(state.runtimeType){
            case DraftsListLoadingSuccessState  : return getSuccessUI(state as DraftsListLoadingSuccessState);
            case DraftsEmptyListState : return getEmptyListScreen();
            default : SizedBox();
          }
          return Container();
        },
        listener: (BuildContext context, DraftsState state) {
           if(state is DraftsAddNewButtonClickState ){
             context.push('${NavigationConstants.ADD_NEW_ENTRY}/${false}/$storyId');
           }
           if(state is DraftListItemClickState){
             context.push('${NavigationConstants.ADD_NEW_ENTRY}/${true}/${state.model.storyId}');
           }
           widget.bloc.add(DraftsListLoadEvent(searchQ:""));
        }
    );
  }

  Widget getEmptyListScreen(){
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text("No Drafts available"),
          ),
        ),
        SizedBox(
            width: double.infinity,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: OutlinedButton(onPressed: (){
                widget.bloc.add(AddNewPostButtonClickEvent());
              },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )
                  ),
                  child: const Text("Add New Post",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16))),
            )),
      ],
    );
  }

  Widget getSuccessUI(DraftsListLoadingSuccessState state){
    return Column(
      children: [
        Expanded(
          child: StoriesListWidget(storyList:state.draftList,onTap: (int i){
            widget.bloc.add(DraftsListItemClickEvent(model: state.draftList[i]));
          },onDismiss: (int i){
            widget.bloc.add(DraftsListItemRemoveEvent(storyId:  state.draftList[i].storyId));
          })
        ),
        SizedBox(
            width: double.infinity,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: OutlinedButton(onPressed: (){
                widget.bloc.add(AddNewPostButtonClickEvent());
              },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )
                  ),
                  child: const Text("Add New Post",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16))),
            )),
      ],
    );
  }
}
