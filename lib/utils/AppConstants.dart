
import '../models/data_model.dart';

class AppConstants {
  static List<String> dropdownItems = [
    'Romance',
    'Thriller',
    'Fantasy',
    'Memories',
    'Fiction'
  ];
  static const APP_NAME = "Novalate";

  static List<StoryModel> draftList = [];
  static List<StoryModel> feedsList = [];
  static List<StoryModel> storyList = [];
  static const List<String> routes = ['/home', '/feeds', '/drafts'];
  static const List<String> bottomNav = ['HOME', 'FEEDS', 'DRAFTS'];
  static const List<String> contentList = ['Shows all the works filtered by categories',
    'Shows all the works available in all categories here',
    'Shows all the unfinished works as drafts here for later submission'];
}