part of '../bloc/feed_bloc.dart';

abstract class FeedState {}
abstract class FeedActionState extends FeedState{}

final class FeedInitial extends FeedState {}

class FeedInitialLoadSuccessState extends FeedState{
  List<StoryModel> storyList;
  FeedInitialLoadSuccessState({required this.storyList});
}

class FeedInitialEmptyState extends FeedState {
  FeedInitialEmptyState();
}

class FeedClickSuccessState extends FeedActionState {
  final String storyId;
  FeedClickSuccessState({required this.storyId});
}

class StoryReaderInitialState extends FeedState {
  final StoryModel story;
  StoryReaderInitialState({required this.story});
}