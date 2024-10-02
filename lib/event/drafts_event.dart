part of '../bloc/drafts_bloc.dart';

abstract class DraftsEvent {}

class DraftsListLoadEvent extends DraftsEvent{
  final String searchQ;
  DraftsListLoadEvent({required this.searchQ});
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

class AddImageButtonClickEvent extends DraftsEvent{
  AddImageButtonClickEvent();
}

class SelectCategoryOption extends DraftsEvent{
  String option;
  SelectCategoryOption({required this.option});
}

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
  final File? imageUrl;
  NewPostSubmitEvent({
    required this.story,
    required this.imageUrl
  });
}

class UpdateDraftSubmitEvent extends DraftsEvent{
  final StoryModel story;
  final File? imageUrl;
  UpdateDraftSubmitEvent({
    required this.story,
    required this.imageUrl
  });
}