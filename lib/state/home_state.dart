part of '../bloc/home_bloc.dart';

abstract class HomeState {}
abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class FilterSearchClickedState extends HomeActionState {
  final String query;
  FilterSearchClickedState({required this.query});
}
final class InfoAlertClickedState extends HomeActionState {
  final String category;
  InfoAlertClickedState({required this.category});
}
