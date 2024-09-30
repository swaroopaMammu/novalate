import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/bloc/drafts_bloc.dart';
import 'package:novalate/ui/screens/AddNewEntryScreen.dart';
import 'package:novalate/ui/screens/CategoryScreen.dart';
import 'package:novalate/ui/screens/DraftScreen.dart';
import 'package:novalate/ui/screens/FeedScreen.dart';
import 'package:novalate/ui/screens/HomeScreen.dart';
import 'package:novalate/ui/screens/StoryListScreen.dart';
import 'package:novalate/ui/screens/StoryReaderScreen.dart';
import 'package:novalate/utils/AppConstants.dart';
import 'package:novalate/utils/NavigationConstants.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const BaseWidget());
}

class BaseWidget extends StatefulWidget {
  const BaseWidget({super.key});

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  final draftBloc = DraftsBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.APP_NAME,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(
            255, 155, 97, 161)),
        useMaterial3: true,
      ),
      routerConfig:GoRouter(initialLocation: NavigationConstants.HOME, routes: [

        ShellRoute(
          builder: (context, state, child) {
            return HomeScreen(child: child); // Wrapper with bottom navigation bar
          }, routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) {
              return const MaterialPage(child: CategoryScreen());
            },
          ),
          GoRoute(
            path: '/feeds',
            pageBuilder: (context, state) {
              return const MaterialPage(child: FeedScreen());
            },
          ),
          GoRoute(
            path: '/drafts',
            pageBuilder: (context, state) {
              return MaterialPage(child: DraftScreen(bloc: draftBloc));
            },
          ),
        ],
        ),
        GoRoute(
          path: '${NavigationConstants.ADD_NEW_ENTRY}/:isDraft/:storyId',
          name: NavigationConstants.ADD_NEW_ENTRY,
          builder: (context, state) {
            final String isDraft = state.pathParameters['isDraft'] ?? 'false';
            final String storyId = state.pathParameters['storyId'] ?? '';
            var flag = false;
            if(isDraft == 'true'){
              flag = true;
            }
            return AddNewEntryScreen(isDraft: flag,storyId: storyId,bloc: draftBloc);
          },
        ),
        GoRoute(
            path: '${NavigationConstants.STORY_LIST}/:category',
            name: NavigationConstants.STORY_LIST,
            builder: (context, state) {
              final String category = state.pathParameters['category'] ?? '';
              return  StoryListScreen(category: category);
            },
        ),
        GoRoute(
            path: '/${NavigationConstants.STORY_READER}/:storyId',
            name: '/${NavigationConstants.STORY_READER}',
            builder: (context, state) {
              final String storyId = state.pathParameters['storyId'] ?? '';
              return StoryReaderScreen(storyId: storyId);

            }),
      ]) ,
    );
  }
}

