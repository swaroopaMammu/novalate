part of '../bloc/drafts_bloc.dart';

abstract class DraftsState {}
abstract class DraftsActionState extends DraftsState{}

final class DraftsInitial extends DraftsState {}

class DraftsListLoadingSuccessState extends DraftsState{
  final List<StoryModel> draftList;
  DraftsListLoadingSuccessState({required this.draftList});
}
class DraftsEmptyListState extends DraftsState{
  DraftsEmptyListState();
}
class DraftsAddNewButtonClickState extends DraftsActionState{
  DraftsAddNewButtonClickState();
}
class DraftListItemClickState extends DraftsActionState{
  final StoryModel model;
  DraftListItemClickState({required this.model});
}

// new entry screen

class DraftAddImageButtonClickState extends DraftsActionState{
  DraftAddImageButtonClickState();
}

class CategoryOptionState extends DraftsActionState{
  String option;
  CategoryOptionState({required this.option});
}

class DraftEditLoadSuccessState extends DraftsState{
  final StoryModel story;
  DraftEditLoadSuccessState({
    required this.story
  });
}

class NewEntryLoadSuccessState extends DraftsState{
  NewEntryLoadSuccessState();
}

class NewPostSubmitState extends DraftsActionState{
  final String result;
  NewPostSubmitState({required this.result});
}
