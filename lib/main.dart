import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/ui/screens/AddNewEntryScreen.dart';
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

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.APP_NAME,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(
            255, 155, 97, 161)),
        useMaterial3: true,
      ),
      routerConfig:_router ,
    );
  }
}

final _router = GoRouter(initialLocation: NavigationConstants.HOME, routes: [
  GoRoute(
      path: NavigationConstants.HOME,
      name: NavigationConstants.HOME,
      builder: (context, state) => const HomeScreen(),
    ),
  GoRoute(
    path: '${NavigationConstants.ADD_NEW_ENTRY}/:isDraft/:title',
    name: NavigationConstants.ADD_NEW_ENTRY,
    builder: (context, state) {
      final String isDraft = state.pathParameters['isDraft'] ?? 'false';
      final String title = state.pathParameters['title'] ?? '';
      var flag = false;
      if(isDraft == 'true'){
        flag = true;
      }
      return AddNewEntryScreen(isDraft: flag,title: title);
    },
  ),
  GoRoute(
      path: NavigationConstants.STORY_LIST,
      name: NavigationConstants.STORY_LIST,
      builder: (context, state) => const StoryListScreen(),
      routes: <RouteBase>[
        GoRoute(
            path: NavigationConstants.STORY_READER,
            name: NavigationConstants.STORY_READER,
            builder: (context, state) => const StoryReaderScreen()),
      ]
    ),
  GoRoute(
      path: '/${NavigationConstants.STORY_READER}',
      name: '/${NavigationConstants.STORY_READER}',
      builder: (context, state) => const StoryReaderScreen()),
]);

