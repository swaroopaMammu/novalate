part of '../bloc/feed_bloc.dart';

abstract class FeedEvent {}

class FeedsInitialLoadEvent extends FeedEvent{
  FeedsInitialLoadEvent();
}

class FeedsClickEvent extends FeedEvent{
  final String storyId;
  FeedsClickEvent({required this.storyId});
}

class StoryReaderInitialLoadEvent extends FeedEvent{
  String storyId;
  StoryReaderInitialLoadEvent({required this.storyId});
}
