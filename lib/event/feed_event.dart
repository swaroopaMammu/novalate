part of '../bloc/feed_bloc.dart';

abstract class FeedEvent {}

class FeedsInitialLoadEvent extends FeedEvent{
  final String searchQ;
  FeedsInitialLoadEvent({required this.searchQ});
}

class FeedsClickEvent extends FeedEvent{
  final String storyId;
  FeedsClickEvent({required this.storyId});
}

class StoryReaderInitialLoadEvent extends FeedEvent{
  String storyId;
  StoryReaderInitialLoadEvent({required this.storyId});
}
