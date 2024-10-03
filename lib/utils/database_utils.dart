import '../models/data_model.dart';
import 'AppConstants.dart';
import 'firebase_fire_store.dart';

Future<List<StoryModel>> getDataFromFireStore(bool isFromDraft)async{
  final db = DatabaseService();
  List<Map<String, dynamic>> dataList =  await db.read();
  List<StoryModel> draftList =  [];
  List<StoryModel> feedsList =  [];
  for(var d in dataList){
    final m = StoryModel(d[AppConstants.TITLE_PARAM], d[AppConstants.AUTHOR_PARAM],
        d[AppConstants.CATEGORY_PARAM], d[AppConstants.IMAGE_PARAM], d[AppConstants.STORY_PARAM],
        d[AppConstants.IS_DRAFT_PARAM],d[AppConstants.STORY_ID_PARAM]);
    if(d[AppConstants.IS_DRAFT_PARAM] == true){
      draftList.add(m);
    }else{
      feedsList.add(m);
    }
  }
  if(isFromDraft){
    return draftList;
  }
  return feedsList;
}


List<StoryModel> getFilteredDraftList(String query,List<StoryModel> draftList){
  List<StoryModel> filteredList = draftList.where((story) => story.title.contains(query)).toList();
  return filteredList;
}

List<StoryModel> getFilteredFeedsList(String query,List<StoryModel> feedsList){
  List<StoryModel> filteredList = feedsList.where((story) => story.title.contains(query)).toList();
  return filteredList;
}