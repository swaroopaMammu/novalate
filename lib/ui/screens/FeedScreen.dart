import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/utils/NavigationConstants.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20,
      itemBuilder: (context, index) {
        return  GestureDetector(
          onTap: (){
            context.pushNamed(NavigationConstants.STORY_READER);
          },
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset('assets/images/spirited_away.jpeg', fit: BoxFit.cover),
                  Text("Title",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  Text("Auther name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                  Text("Category",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300))
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
    );
  }
}
