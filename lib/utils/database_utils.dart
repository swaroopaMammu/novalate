import '../models/data_model.dart';
import 'AppConstants.dart';
import 'firebase_fire_store.dart';

getDataFromFireStore()async{
  final db = DatabaseService();
  List<Map<String, dynamic>> dataList =  await db.read();
  List<StoryModel> draftList =  [];
  List<StoryModel> feedsList =  [];
  for(var d in dataList){
    final m = StoryModel(d["title"], d["author"], d["category"],
        d["image"], d["story"], d["isDraft"],d["storyId"]);
    if(d["isDraft"] == true){
      draftList.add(m);
    }else{
      feedsList.add(m);
    }
  }
  AppConstants.draftList.clear();
  AppConstants.feedsList.clear();
  AppConstants.draftList.addAll(draftList);
  AppConstants.feedsList.addAll(feedsList);
}


List<StoryModel> getFilteredDraftList(String query){
  List<StoryModel> filteredList = AppConstants.draftList.where((story) => story.title.contains(query)).toList();
  return filteredList;
}

List<StoryModel> getFilteredFeedsList(String query){
  List<StoryModel> filteredList = AppConstants.feedsList.where((story) => story.title.contains(query)).toList();
  return filteredList;
}