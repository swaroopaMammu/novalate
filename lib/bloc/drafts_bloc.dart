import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:novalate/models/data_model.dart';
import 'package:novalate/utils/AppConstants.dart';

import '../utils/database_utils.dart';
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
    on<AddImageButtonClickEvent>(addImageButtonClickEvent);
    on<SelectCategoryOption>(selectCategoryOption);

  }


  FutureOr<void> draftInitialLoadEvent(DraftsListLoadEvent event, Emitter<DraftsState> emit) async{
     await getDataFromFireStore();
    if(AppConstants.draftList.isEmpty) {
      emit(DraftsEmptyListState());
    }
    else{
      if(event.searchQ != ""){
        final list = getFilteredDraftList(event.searchQ);
        if(list.isEmpty){
          emit(DraftsEmptyListState());
        }else{
          emit(DraftsListLoadingSuccessState(draftList: getFilteredDraftList(event.searchQ)));
        }
      }else{
        emit(DraftsListLoadingSuccessState(draftList: AppConstants.draftList));
      }
    }
  }

  FutureOr<void> draftListItemClickEvent(DraftsListItemClickEvent event, Emitter<DraftsState> emit) {
    emit(DraftListItemClickState(model: event.model));
  }

  FutureOr<void> draftsListItemRemoveEvent(DraftsListItemRemoveEvent event, Emitter<DraftsState> emit) async{
    await db.delete(event.storyId);
    List<StoryModel> newList = [];
    for(var item in AppConstants.draftList){
      if(item.storyId != event.storyId){
        newList.add(item);
      }
    }
    AppConstants.draftList.clear();
    AppConstants.draftList.addAll(newList);
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