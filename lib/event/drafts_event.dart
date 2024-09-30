part of '../bloc/drafts_bloc.dart';

abstract class DraftsEvent {}

class DraftsListLoadEvent extends DraftsEvent{
  DraftsListLoadEvent();
}

class DraftsListItemClickEvent extends DraftsEvent{
  final StoryModel model;
  DraftsListItemClickEvent({required this.model});
}

class DraftsListItemRemoveEvent extends DraftsEvent{
  final String storyId;
  DraftsListItemRemoveEvent({required this.storyId});
}
class AddNewPostButtonClickEvent extends DraftsEvent{
  AddNewPostButtonClickEvent();
}
// new entry screen

class DraftEditLoadEvent extends DraftsEvent{
  final String storyId ;
  DraftEditLoadEvent({
    required this.storyId
  });
}

class NewPostEntryLoadEvent extends DraftsEvent{
  NewPostEntryLoadEvent();
}

class NewPostSubmitEvent extends DraftsEvent{
  final StoryModel story;
  NewPostSubmitEvent({
    required this.story
  });
}

class UpdateDraftSubmitEvent extends DraftsEvent{
  final StoryModel story;
  UpdateDraftSubmitEvent({
    required this.story
  });
}