

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/home_bloc.dart';
import '../../utils/AppConstants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,required this.child, required this.bloc});
  final Widget child;
  final HomeBloc bloc;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomBarIndex = 0;
  final _fController = TextEditingController();

  void _onTap(int index) {
      setState(() {
        bottomBarIndex = index;
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
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
            child: Expanded(
              child: TextField(
                controller: _fController,
                decoration: InputDecoration(
                  hintText: "Search your choice here",
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  prefixIcon: IconButton(onPressed: (){
                    widget.bloc.add(FilterSearchClickedEvent(category: AppConstants.bottomNav[bottomBarIndex], query: _fController.text));
                  }, icon: const Icon(Icons.search)),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          )
      ),
    );
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
