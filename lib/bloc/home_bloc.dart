import 'dart:async';

import 'package:bloc/bloc.dart';


part '../event/home_event.dart';
part '../state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FilterSearchClickedEvent>(filterSearchClickedEvent);
    on<InfoAlertClickedEvent>(infoAlertClickedEvent);
  }

  FutureOr<void> filterSearchClickedEvent(FilterSearchClickedEvent event, Emitter<HomeState> emit) {
    emit(FilterSearchClickedState(query: event.query,category: event.category));
  }

  FutureOr<void> infoAlertClickedEvent(InfoAlertClickedEvent event, Emitter<HomeState> emit) {
    emit(InfoAlertClickedState(category: event.category));
  }
}
