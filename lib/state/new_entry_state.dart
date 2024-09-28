part of '../bloc/new_entry_bloc.dart';

abstract class NewEntryState {}
abstract class NewEntryActionState extends NewEntryState {}

final class NewEntryInitial extends NewEntryState {}

class DraftPageLoadSuccessState extends NewEntryState{
  final StoryModel story;
  DraftPageLoadSuccessState({
    required this.story
});
}

class NewPostLoadSuccessState extends NewEntryState{
  NewPostLoadSuccessState();
}

class NewPostSubmitState extends NewEntryActionState{
  final result;
  NewPostSubmitState({required this.result});
}

