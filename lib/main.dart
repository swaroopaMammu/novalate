import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:novalate/bloc/category_bloc.dart';
import 'package:novalate/bloc/drafts_bloc.dart';
import 'package:novalate/bloc/feed_bloc.dart';
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
  final feedBloc = FeedBloc();
  final categoryBloc = CategoryBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.APP_NAME,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(
            255, 155, 97, 161)),
        useMaterial3: true,
      ),
      routerConfig: NavigationConstants().getRouter(categoryBloc,draftBloc,feedBloc)
    );
  }
}

