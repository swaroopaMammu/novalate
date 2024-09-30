import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:novalate/models/data_model.dart';
import 'package:novalate/utils/AppConstants.dart';

import '../utils/firebase_fire_store.dart';

part '../event/drafts_event.dart';
part '../state/drafts_state.dart';

class DraftsBloc extends Bloc<DraftsEvent, DraftsState> {
  final db = DatabaseService();
  DraftsBloc() : super(DraftsInitial()) {
    on<DraftsListLoadEvent>(draftInitialLoadEvent);
    on<DraftsListItemClickEvent>(draftListItemClickEvent);
    on<DraftsListItemRemoveEvent>(draftsListItemRemoveEvent);
    on<AddNewPostButtonClickEvent>(addNewPostClickEvent);

    on<DraftEditLoadEvent>(draftEditLoadEvent);
    on<NewPostEntryLoadEvent>(newPostEntryLoadEvent);
    on<NewPostSubmitEvent>(newPostSubmitEvent);
    on<UpdateDraftSubmitEvent>(updateDraftSubmitEvent);

  }


  FutureOr<void> draftInitialLoadEvent(DraftsListLoadEvent event, Emitter<DraftsState> emit) async{
    List<Map<String, dynamic>> dataList =  await db.read();
    List<StoryModel> draftList =  [];
    List<StoryModel> storyList =  [];
    for(var d in dataList){
      final m = StoryModel(d["title"], d["author"], d["category"],
          d["image"], d["story"], d["isDraft"],d["storyId"]);
      if(d["isDraft"] == true){
        draftList.add(m);
      }else{
        storyList.add(m);
      }
    }
    AppConstants.draftList.clear();
    AppConstants.feedsList.clear();
    AppConstants.draftList.addAll(draftList);
    AppConstants.feedsList.addAll(storyList);
    Logger().d("drafts : ${AppConstants.draftList}");
    Logger().d("drafts feeds : ${AppConstants.feedsList}");
    if(AppConstants.draftList.isEmpty) {
      emit(DraftsEmptyListState());
    }
    else{
      emit(DraftsListLoadingSuccessState(draftList: AppConstants.draftList));
    }
  }

  FutureOr<void> draftListItemClickEvent(DraftsListItemClickEvent event, Emitter<DraftsState> emit) {
    emit(DraftListItemClickState(model: event.model));
  }

  FutureOr<void> draftsListItemRemoveEvent(DraftsListItemRemoveEvent event, Emitter<DraftsState> emit) {
    db.delete(event.storyId);
    emit(DraftsListLoadingSuccessState(draftList: AppConstants.draftList));
  }

  FutureOr<void> addNewPostClickEvent(AddNewPostButtonClickEvent event, Emitter<DraftsState> emit) {
    emit(DraftsAddNewButtonClickState());
  }

  FutureOr<void> draftEditLoadEvent(DraftEditLoadEvent event, Emitter<DraftsState> emit) {
    for(var story in AppConstants.draftList){
      if(story.storyId == event.storyId){
        emit(DraftEditLoadSuccessState(story: story));
      }
    }
  }

  FutureOr<void> newPostEntryLoadEvent(NewPostEntryLoadEvent event, Emitter<DraftsState> emit) {
    emit(NewEntryLoadSuccessState());
  }

  FutureOr<void> newPostSubmitEvent(NewPostSubmitEvent event, Emitter<DraftsState> emit) {
    db.create(event.story);
    emit(NewPostSubmitState(result:"success"));
  }

  FutureOr<void> updateDraftSubmitEvent(UpdateDraftSubmitEvent event, Emitter<DraftsState> emit) {
    db.update(event.story);
    emit(NewPostSubmitState(result:"success"));
  }
}