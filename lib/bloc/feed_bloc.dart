import 'dart:async';

import 'package:bloc/bloc.dart';

import '../models/data_model.dart';
import '../utils/database_utils.dart';

part '../event/feed_event.dart';
part '../state/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  static List<StoryModel> feedsList = [];
  FeedBloc() : super(FeedInitial()) {
    on<FeedsInitialLoadEvent>(feedsInitialLoadEvent);
    on<FeedsClickEvent>(feedsClickEvent);
    on<StoryReaderInitialLoadEvent>(storyReaderInitialLoadEvent);
  }


  FutureOr<void> feedsInitialLoadEvent(FeedsInitialLoadEvent event, Emitter<FeedState> emit)async{
    List<StoryModel> storyList = await getDataFromFireStore(false);
    feedsList.clear();
    feedsList.addAll(storyList);
    if(feedsList.isEmpty){
      emit(FeedInitialEmptyState());
    }else{
      if(event.searchQ != ""){
        final list = getFilteredFeedsList(event.searchQ,feedsList);
        if(list.isEmpty){
          emit(FeedInitialEmptyState());
        }else{
          emit(FeedInitialLoadSuccessState(storyList: getFilteredFeedsList(event.searchQ,feedsList)));
        }
      }else{
        emit(FeedInitialLoadSuccessState(storyList: feedsList));
     }
    }
  }

  FutureOr<void> feedsClickEvent(FeedsClickEvent event, Emitter<FeedState> emit) {
    emit(FeedClickSuccessState(storyId: event.storyId));
  }
  FutureOr<void> storyReaderInitialLoadEvent(StoryReaderInitialLoadEvent event, Emitter<FeedState> emit) {
    for(var story in feedsList){
      if(story.storyId == event.storyId){
        emit(StoryReaderInitialState(story: story));
      }
    }
  }
}
