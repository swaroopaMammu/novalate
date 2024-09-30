import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:novalate/utils/firebase_fire_store.dart';

import '../models/data_model.dart';
import '../utils/AppConstants.dart';

part '../event/category_event.dart';
part '../state/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryInitialLoadEvent>(categoryInitialLoadEvent);
    on<CategoryCardClickEvent>(categoryCardClickEvent);

    on<StoryListInitialLoadEvent>(storyListInitialLoadEvent);
    on<StoryClickEvent>(storyClickEvent);
  }

  FutureOr<void> categoryInitialLoadEvent(CategoryInitialLoadEvent event, Emitter<CategoryState> emit) async{
    final db = DatabaseService();
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
    emit(CategoryInitialState());
  }

  FutureOr<void> categoryCardClickEvent(CategoryCardClickEvent event, Emitter<CategoryState> emit) {
      emit(CategoryCardClickState(category: event.category));
  }

  FutureOr<void> storyListInitialLoadEvent(StoryListInitialLoadEvent event, Emitter<CategoryState> emit) async{
    List<StoryModel> storyList =  [];
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
}
