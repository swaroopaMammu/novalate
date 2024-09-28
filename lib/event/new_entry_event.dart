part of '../bloc/new_entry_bloc.dart';

abstract class NewEntryEvent {}

class DraftPageLoadSuccessEvent extends NewEntryEvent{
  final String title ;
  DraftPageLoadSuccessEvent({
    required this.title
  });
}

class NewPostLoadSuccessEvent extends NewEntryEvent{
  NewPostLoadSuccessEvent();
}

class NewPostSubmitEvent extends NewEntryEvent{
  final StoryModel story;
  NewPostSubmitEvent({
    required this.story
  });
}