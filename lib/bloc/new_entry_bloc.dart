import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part '../event/new_entry_event.dart';
part '../state/new_entry_state.dart';

class NewEntryBloc extends Bloc<NewEntryEvent, NewEntryState> {
  NewEntryBloc() : super(NewEntryInitial()) {
    on<NewEntryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
