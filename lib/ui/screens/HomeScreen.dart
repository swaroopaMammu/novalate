

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/bloc/category_bloc.dart';
import 'package:novalate/bloc/drafts_bloc.dart';
import 'package:novalate/bloc/feed_bloc.dart';
import '../../utils/AppConstants.dart';
import '../widgets/top_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,required this.child,
    required this.cBloc,required this.dBloc,required this.fBloc});
  final Widget child;
  final CategoryBloc cBloc;
  final DraftsBloc dBloc;
  final FeedBloc fBloc;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int bottomBarIndex;
  late final TextEditingController _fController;

  void _onTap(int index) {
      setState(() {
        bottomBarIndex = index;
        _fController.text = "";
      });
    context.go(AppConstants.routes[bottomBarIndex]); // Navigate to selected route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      bottomNavigationBar: getBottomNavBar(),
      body: widget.child
    );
  }


  @override
  void initState() {
    super.initState();
    _fController = TextEditingController();
    bottomBarIndex = 0;
  }

  @override
  void dispose() {
    _fController.dispose();
    super.dispose();
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${AppConstants.bottomNav[bottomBarIndex]} Info"),
          content: Text(AppConstants.contentList[bottomBarIndex]),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  AppBar getAppBar(){
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 17, 68, 117),
      title: const Text("Choice of yours",style: TextStyle(color: Colors.white),),
      centerTitle: true,
      actions: [
        IconButton(onPressed: (
            ){
          _showAlertDialog(context);
        }, icon: const Icon(Icons.info_outline,color: Colors.white))
      ],
      elevation: 20.0,
      bottom: displayTopBarSearch()
    );
  }

  PreferredSizeWidget displayTopBarSearch(){
    final bool isHome = bottomBarIndex ==0;
    return  PreferredSize(
        preferredSize: Size.fromHeight(60), child: Padding(
        padding: isHome ? const EdgeInsets.fromLTRB(16, 10, 16, 20) : const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
        child: isHome ? Text("\" Novalate inspires the storyteller within \"",
        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 20),) :
        Expanded(
            child:  TopSearchBar(sController: _fController ,onSearch: (String query){
              switch(bottomBarIndex){
                case 1: widget.fBloc.add(FeedsInitialLoadEvent(searchQ: query));
                case 2: widget.dBloc.add(DraftsListLoadEvent(searchQ: query));
              }
            })
        ),
    ),);
  }

 Widget getBottomNavBar(){
   return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      backgroundColor:const Color.fromARGB(255, 17, 68, 117),
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: const IconThemeData(color: Colors.black),
      onTap: _onTap,
      currentIndex: bottomBarIndex,
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.home),
          label: AppConstants.bottomNav[0],
        ), BottomNavigationBarItem(icon: const Icon(Icons.feed),
            label: AppConstants.bottomNav[1]
        ), BottomNavigationBarItem(icon: const Icon(Icons.drafts),
            label: AppConstants.bottomNav[2]
        )
      ],
    );
  }
}
