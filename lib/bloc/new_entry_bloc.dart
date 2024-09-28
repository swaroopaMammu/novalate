import 'package:bloc/bloc.dart';
import 'package:novalate/models/data_model.dart';
import 'package:novalate/utils/firebase_fire_store.dart';

part '../event/new_entry_event.dart';
part '../state/new_entry_state.dart';

class NewEntryBloc extends Bloc<NewEntryEvent, NewEntryState> {
  NewEntryBloc() : super(NewEntryInitial()) {
    final db = DatabaseService();
    on<DraftPageLoadSuccessEvent>((event, emit) async {
      List<Map<String, dynamic>> dataList =  await db.read();
      if(dataList.isEmpty){
        emit(DraftPageLoadSuccessState(story: StoryModel("","","","","",false)));
      }else{
        for(var d in dataList){
            if(d["title"] == event.title){
              final story = StoryModel(d["title"], d["author"], d["category"], d["image"], d["story"], d["isDraft"]);
              emit(DraftPageLoadSuccessState(story: story));
            }
        }
      }
    });
    on<NewPostSubmitEvent>((event, emit){
      db.create(event.story);
      emit(NewPostSubmitState(result:"success"));
    });
    on<NewPostLoadSuccessEvent>((event, emit){
      emit(NewPostLoadSuccessState());
    });
  }
}
