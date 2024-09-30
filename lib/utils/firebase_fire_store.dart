
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/data_model.dart';

class DatabaseService{
  final _fireStore = FirebaseFirestore.instance;

  create(StoryModel model){
   try{
     _fireStore.collection("stories").add({
       "title":model.title,
       "author":model.author,
       "category":model.category,
       "image":model.image,
       "story":model.story,
       "isDraft":model.isDraft
     });
   }catch(e){
     log(e.toString());
   }
  }

  Future<List<Map<String, dynamic>>> read() async{
    try{
    final dataList  = await  _fireStore.collection("stories").get();
    List<Map<String, dynamic>> stories = dataList.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['storyId'] = doc.id;
      return data;
    }).toList();

    return stories;
    }catch(e){
      log(e.toString());
      return [];
    }
  }

  Future<void> update( StoryModel model) async {
    try {
      await _fireStore.collection("stories").doc(model.storyId).update({
        "title": model.title,
        "author": model.author,
        "category": model.category,
        "image": model.image,
        "story": model.story,
        "isDraft": model.isDraft,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> delete(String docId) async {
    try {
      await _fireStore.collection("stories").doc(docId).delete();
    } catch (e) {
      log("Error deleting document: $e");
    }
  }

}