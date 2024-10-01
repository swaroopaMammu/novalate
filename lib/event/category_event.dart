part of '../bloc/category_bloc.dart';

abstract class CategoryEvent {}

class CategoryInitialLoadEvent extends CategoryEvent{
  CategoryInitialLoadEvent();
}

class CategoryCardClickEvent extends CategoryEvent{
  String category;
  CategoryCardClickEvent({required this.category});
}

class StoryListInitialLoadEvent extends CategoryEvent{
  final String category;
  StoryListInitialLoadEvent({required this.category});
}

class StoryClickEvent extends CategoryEvent{
  final String storyId;
  StoryClickEvent({required this.storyId});
}

class StoryRemoveClickEvent extends CategoryEvent{
  final String storyId;
  StoryRemoveClickEvent({required this.storyId});
}