part of '../bloc/home_bloc.dart';

abstract class HomeEvent {}

class FilterSearchClickedEvent extends HomeEvent{
  final String query;
  final String category;
  FilterSearchClickedEvent({required this.category, required this.query});
}

class InfoAlertClickedEvent extends HomeEvent{
  final String category;
  InfoAlertClickedEvent({required this.category});
}
