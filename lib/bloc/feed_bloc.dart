import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:novalate/utils/AppConstants.dart';

import '../models/data_model.dart';
import '../utils/database_utils.dart';

part '../event/feed_event.dart';
part '../state/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {

  FeedBloc() : super(FeedInitial()) {
    on<FeedsInitialLoadEvent>(feedsInitialLoadEvent);
    on<FeedsClickEvent>(feedsClickEvent);
    on<StoryReaderInitialLoadEvent>(storyReaderInitialLoadEvent);
  }


  FutureOr<void> feedsInitialLoadEvent(FeedsInitialLoadEvent event, Emitter<FeedState> emit)async{
    await getDataFromFireStore();
    if(AppConstants.feedsList.isEmpty){
      emit(FeedInitialEmptyState());
    }else{
      if(event.searchQ != ""){
        final list = getFilteredFeedsList(event.searchQ);
        if(list.isEmpty){
          emit(FeedInitialEmptyState());
        }else{
          emit(FeedInitialLoadSuccessState(storyList: getFilteredFeedsList(event.searchQ)));
        }
      }else{
        emit(FeedInitialLoadSuccessState(storyList: AppConstants.feedsList));
     }
    }
  }

  FutureOr<void> feedsClickEvent(FeedsClickEvent event, Emitter<FeedState> emit) {
    emit(FeedClickSuccessState(storyId: event.storyId));
  }
  FutureOr<void> storyReaderInitialLoadEvent(StoryReaderInitialLoadEvent event, Emitter<FeedState> emit) {
    for(var story in AppConstants.feedsList){
      if(story.storyId == event.storyId){
        emit(StoryReaderInitialState(story: story));
      }
    }
  }
}
