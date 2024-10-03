import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/bloc/category_bloc.dart';
import 'package:novalate/bloc/drafts_bloc.dart';
import 'package:novalate/bloc/feed_bloc.dart';

import '../ui/screens/AddNewEntryScreen.dart';
import '../ui/screens/CategoryScreen.dart';
import '../ui/screens/DraftScreen.dart';
import '../ui/screens/FeedScreen.dart';
import '../ui/screens/HomeScreen.dart';
import '../ui/screens/StoryListScreen.dart';
import '../ui/screens/StoryReaderScreen.dart';

class NavigationConstants{

  static const HOME = '/home';
  static const FEEDS = '/feeds';
  static const DRAFTS = '/drafts';
  static const ADD_NEW_ENTRY = '/addNewEntry';
  static const STORY_LIST = '/storyList';
  static const STORY_READER = 'storyReader';
  static const ISDRAFT_PARAM = 'isDraft';
  static const STORYID_PARAM = 'storyId';
  static const CATEGORY_PARAM = 'category';
  static const TRUE_VALUE = 'true';
  static const FALSE_VALUE = 'false';
  static const IS_FROM_PARAM = 'isfrom';

  GoRouter getRouter(CategoryBloc categoryBloc, DraftsBloc draftBloc, FeedBloc feedBloc){
    return GoRouter(initialLocation: NavigationConstants.HOME, routes: [
      ShellRoute(
        builder: (context, state, child) {
          return HomeScreen(cBloc: categoryBloc,dBloc: draftBloc,fBloc: feedBloc, child: child); // Wrapper with bottom navigation bar
        }, routes: [
        GoRoute(
          path: HOME,
          pageBuilder: (context, state) {
            return  const MaterialPage(child: CategoryScreen());
          },
        ),
        GoRoute(
          path: FEEDS,
          pageBuilder: (context, state) {
            return  MaterialPage(child: FeedScreen(feedBloc:feedBloc));
          },
        ),
        GoRoute(
          path: DRAFTS,
          pageBuilder: (context, state) {
            return MaterialPage(child: DraftScreen(bloc: draftBloc));
          },
        ),
      ],
      ),
      GoRoute(
        path: '${ADD_NEW_ENTRY}/:$ISDRAFT_PARAM/:$STORYID_PARAM',
        name: ADD_NEW_ENTRY,
        builder: (context, state) {
          final String isDraft = state.pathParameters[ISDRAFT_PARAM] ?? FALSE_VALUE;
          final String storyId = state.pathParameters[STORYID_PARAM] ?? '';
          var flag = false;
          if(isDraft == TRUE_VALUE){
            flag = true;
          }
          return AddNewEntryScreen(isDraft: flag,storyId: storyId,bloc: draftBloc);
        },
      ),
      GoRoute(
        path: '${STORY_LIST}/:$CATEGORY_PARAM',
        name: STORY_LIST,
        builder: (context, state) {
          final String category = state.pathParameters[CATEGORY_PARAM] ?? '';
          return  StoryListScreen(category: category);
        },
      ),
      GoRoute(
          path: '/${STORY_READER}/:$STORYID_PARAM',
          name: '/${STORY_READER}',
          builder: (context, state) {
            final String storyId = state.pathParameters[STORYID_PARAM] ?? '';
            final String isFrom = state.pathParameters[IS_FROM_PARAM] ?? FEEDS;
            if(isFrom == CATEGORY_PARAM){
              return StoryReaderScreen(storyId: storyId);
            }
            return StoryReaderScreen(storyId: storyId);
          }),
    ]);
  }
}