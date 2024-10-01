
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/data_model.dart';

class DatabaseService{
  final _fireStore = FirebaseFirestore.instance;
  final _fireStorage = FirebaseStorage.instance;

  create(StoryModel model,File? image)async{
    var url = "";
    if(image != null){
      url = await getImageUrl(image);
    }
   try{
     _fireStore.collection("stories").add({
       "title":model.title,
       "author":model.author,
       "category":model.category,
       "image":url,
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

  Future<void> update( StoryModel model,File? image) async {
    var url = "";
    if(image != null){
      url = await getImageUrl(image);
    }
    try {
      await _fireStore.collection("stories").doc(model.storyId).update({
        "title": model.title,
        "author": model.author,
        "category": model.category,
        "image": url,
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

  Future<String> getImageUrl(File image) async{
     try{
       var storeImage =  _fireStorage.ref().child(image.path);
       var task = await storeImage.putFile(image);
       var imgUrl = await task.ref.getDownloadURL();
       return imgUrl;
     }
     catch(e){
       print(e.toString());
       return "";
     }
  }

}