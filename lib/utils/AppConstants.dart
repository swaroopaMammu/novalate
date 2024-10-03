
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
  static const TITLE_PARAM = "title";
  static const AUTHOR_PARAM = "author";
  static const CATEGORY_PARAM = "category";
  static const IMAGE_PARAM = "image";
  static const STORY_PARAM = "story";
  static const IS_DRAFT_PARAM = "isDraft";
  static const STORY_ID_PARAM = "storyId";

  static List<StoryModel> draftList = [];
  static List<StoryModel> feedsList = [];
  static const List<String> routes = ['/home', '/feeds', '/drafts'];
  static const List<String> bottomNav = ['HOME', 'FEEDS', 'DRAFTS'];
  static const List<String> contentList = ['Shows all the works filtered by categories',
    'Shows all the works available in all categories here',
    'Shows all the unfinished works as drafts here for later submission'];

  static const NEW_POST = "New Post";
}