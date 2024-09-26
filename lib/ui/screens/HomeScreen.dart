import 'package:flutter/material.dart';
import 'package:novalate/ui/screens/CategoryScreen.dart';
import 'package:novalate/ui/screens/DraftScreen.dart';
import 'package:novalate/ui/screens/FeedScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomBarIndex = 0;

  final List<Widget> _widgetList = [
    CategoryScreen(),FeedScreen(),Draftscreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      bottomNavigationBar: getBottomNavBar(),
      body: _widgetList[bottomBarIndex],
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
      onTap: (value){
        setState(() {
          bottomBarIndex = value;
        });
      },
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
