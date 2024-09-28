
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
    List<Map<String, dynamic>> stories = dataList.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    return stories;
    }catch(e){
      log(e.toString());
      return [];
    }
  }

}