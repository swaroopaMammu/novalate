import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:novalate/utils/firebase_fire_store.dart';

import '../models/data_model.dart';
import '../utils/AppConstants.dart';
import '../utils/database_utils.dart';

part '../event/category_event.dart';
part '../state/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<StoryModel> storyList =  [];
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryInitialLoadEvent>(categoryInitialLoadEvent);
    on<CategoryCardClickEvent>(categoryCardClickEvent);

    on<StoryListInitialLoadEvent>(storyListInitialLoadEvent);
    on<StoryClickEvent>(storyClickEvent);
    on<StoryRemoveClickEvent>(storyRemoveClickEvent);
    on<StoryInitialLoadEvent>(storyReaderInitialLoadEvent);
  }

  FutureOr<void> categoryInitialLoadEvent(CategoryInitialLoadEvent event, Emitter<CategoryState> emit) async{
    await getDataFromFireStore();
      emit(CategoryInitialState());
  }

  FutureOr<void> categoryCardClickEvent(CategoryCardClickEvent event, Emitter<CategoryState> emit) {
      emit(CategoryCardClickState(category: event.category));
  }

  FutureOr<void> storyListInitialLoadEvent(StoryListInitialLoadEvent event, Emitter<CategoryState> emit) async{
    storyList.clear();
    for(var story in AppConstants.feedsList){
      if( story.category == event.category){
        final m = StoryModel(story.title, story.author, story.category,
            story.image, story.story, story.isDraft,story.storyId);
        storyList.add(m);
      }
    }
    if(storyList.isEmpty){
      emit(StoryListLoadEmpty());
    }else{
      emit(StoryListLoadSuccess(storyList: storyList));
    }
  }

  FutureOr<void> storyClickEvent(StoryClickEvent event, Emitter<CategoryState> emit) {
    emit(StoryClickSuccess(storyId: event.storyId));
  }

  FutureOr<void> storyRemoveClickEvent(StoryRemoveClickEvent event, Emitter<CategoryState> emit) async{
    final db = DatabaseService();
    List<StoryModel> newList = [];
    await db.delete(event.storyId);
    for(var item in storyList){
      if(item.storyId != event.storyId){
        newList.add(item);
      }
    }
    storyList.clear();
    storyList.addAll(newList);
    emit(StoryListLoadSuccess(storyList:storyList));
  }

  FutureOr<void> storyReaderInitialLoadEvent(StoryInitialLoadEvent event, Emitter<CategoryState> emit) {
    for(var story in storyList){
      if(story.storyId == event.storyId){
        emit(StoryInitialState(story: story));
      }
    }
  }
}
