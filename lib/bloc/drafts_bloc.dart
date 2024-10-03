import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:novalate/models/data_model.dart';

import '../utils/database_utils.dart';
import '../utils/firebase_fire_store.dart';

part '../event/drafts_event.dart';
part '../state/drafts_state.dart';

class DraftsBloc extends Bloc<DraftsEvent, DraftsState> {
  static List<StoryModel> draftList = [];
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
    on<AddImageButtonClickEvent>(addImageButtonClickEvent);
    on<SelectCategoryOption>(selectCategoryOption);

  }


  FutureOr<void> draftInitialLoadEvent(DraftsListLoadEvent event, Emitter<DraftsState> emit) async{
    List<StoryModel> storyList = await getDataFromFireStore(true);
    draftList.clear();
    draftList.addAll(storyList);
    if(draftList.isEmpty) {
      emit(DraftsEmptyListState());
    }
    else{
      if(event.searchQ != ""){
        final list = getFilteredDraftList(event.searchQ,draftList);
        if(list.isEmpty){
          emit(DraftsEmptyListState());
        }else{
          emit(DraftsListLoadingSuccessState(draftList: getFilteredDraftList(event.searchQ,draftList)));
        }
      }else{
        emit(DraftsListLoadingSuccessState(draftList: draftList));
      }
    }
  }

  FutureOr<void> draftListItemClickEvent(DraftsListItemClickEvent event, Emitter<DraftsState> emit) {
    emit(DraftListItemClickState(model: event.model));
  }

  FutureOr<void> draftsListItemRemoveEvent(DraftsListItemRemoveEvent event, Emitter<DraftsState> emit) async{
    await db.delete(event.storyId);
    List<StoryModel> newList = [];
    for(var item in draftList){
      if(item.storyId != event.storyId){
        newList.add(item);
      }
    }
    draftList.clear();
    draftList.addAll(newList);
    emit(DraftsListLoadingSuccessState(draftList: draftList));
  }

  FutureOr<void> addNewPostClickEvent(AddNewPostButtonClickEvent event, Emitter<DraftsState> emit) {
    emit(DraftsAddNewButtonClickState());
  }

  FutureOr<void> draftEditLoadEvent(DraftEditLoadEvent event, Emitter<DraftsState> emit) {
    for(var story in draftList){
      if(story.storyId == event.storyId){
        emit(DraftEditLoadSuccessState(story: story));
      }
    }
  }

  FutureOr<void> newPostEntryLoadEvent(NewPostEntryLoadEvent event, Emitter<DraftsState> emit) {
    emit(NewEntryLoadSuccessState());
  }

  FutureOr<void> newPostSubmitEvent(NewPostSubmitEvent event, Emitter<DraftsState> emit) async{
    await db.create(event.story,event.imageUrl);
    emit(NewPostSubmitState(result:"success"));
  }

  FutureOr<void> updateDraftSubmitEvent(UpdateDraftSubmitEvent event, Emitter<DraftsState> emit) async{
    await db.update(event.story,event.imageUrl);
    emit(NewPostSubmitState(result:"success"));
  }

  FutureOr<void> addImageButtonClickEvent(AddImageButtonClickEvent event, Emitter<DraftsState> emit) {
    emit(DraftAddImageButtonClickState());
  }

  FutureOr<void> selectCategoryOption(SelectCategoryOption event, Emitter<DraftsState> emit) {
    emit(CategoryOptionState(option: event.option));
  }
}