part of '../bloc/category_bloc.dart';

abstract class CategoryState {}
abstract class CategoryActionState extends CategoryState{}

final class CategoryInitial extends CategoryState {}
class CategoryInitialState extends CategoryState {
  CategoryInitialState();
}

class CategoryCardClickState extends CategoryActionState {
  String category;
  CategoryCardClickState({required this.category});
}

class StoryListLoadSuccess extends CategoryState{
  final List<StoryModel> storyList;
  StoryListLoadSuccess({required this.storyList});
}

class StoryListLoadEmpty extends CategoryState{
  StoryListLoadEmpty();
}

class StoryClickSuccess extends CategoryActionState{
  final String storyId;
  StoryClickSuccess({required this.storyId});
}
