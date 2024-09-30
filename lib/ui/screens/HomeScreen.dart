

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,required this.child});
  final Widget child;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomBarIndex = 0;



  final List<String> _routes = ['/home', '/feeds', '/drafts'];

  void _onTap(int index) {
      setState(() {
        bottomBarIndex = index;
      });
    context.go(_routes[bottomBarIndex]); // Navigate to selected route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      bottomNavigationBar: getBottomNavBar(),
      body: widget.child
    );
  }

  AppBar getAppBar(){
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 17, 68, 117),
      title: const Text("Choice of yours",style: TextStyle(color: Colors.white),),
      centerTitle: true,
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.info_outline,color: Colors.white))
      ],
      elevation: 20.0,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
            child: Expanded(
              child: TextField(
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
                  prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
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
      backgroundColor:Color.fromARGB(255, 17, 68, 117),
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: const IconThemeData(color: Colors.black),
      onTap: _onTap,
      currentIndex: bottomBarIndex,
      items: const[
        BottomNavigationBarItem(icon: Icon(Icons.home),
          label: "Home",
        ), BottomNavigationBarItem(icon: Icon(Icons.feed),
            label: "Feeds"
        ), BottomNavigationBarItem(icon: Icon(Icons.drafts),
            label: "Drafts"
        )
      ],
    );
  }
}
