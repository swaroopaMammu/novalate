import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/utils/NavigationConstants.dart';

class Draftscreen extends StatelessWidget {
  const Draftscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final title = "the boy";
    return Column(
      children: [
      Expanded(
        child: ListView.separated(
        itemCount: 20,
        itemBuilder: (context, index) {
          return  GestureDetector(
            onTap: (){
              context.push('/${NavigationConstants.ADD_NEW_ENTRY}/${true}/${title}');
            },
            child: Card(
              elevation: 4.0,  // Adds shadow for the card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),  // Rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Item $index',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
            ),
      ),
       SizedBox(
              width: double.infinity,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: OutlinedButton(onPressed: (){
                  context.go('${NavigationConstants.ADD_NEW_ENTRY}/${false}/${title}');
                },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )
                    ),
                    child: const Text("Add New Post",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16))),
              )),
      ],
    );
  }
}
