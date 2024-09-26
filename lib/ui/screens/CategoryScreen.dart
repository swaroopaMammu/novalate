import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/utils/AppConstants.dart';
import 'package:novalate/utils/NavigationConstants.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount:  AppConstants.dropdownItems.length + 1,
          itemBuilder: (context, index) {
            if (index == AppConstants.dropdownItems.length) {
              return Container(
                height: 100,
                color: Colors.transparent,
              );
            }
            return
              InkWell(
                onTap: (){
                  context.pushNamed(NavigationConstants.STORY_LIST);
                },
                child: Container(
                  height: (index % 5 + 1) * 100,
                  decoration: BoxDecoration(
                      color:  const Color.fromARGB(255, 130, 151, 170),
                  //  Color.fromARGB(128, 246, 239, 239),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Center(
                    child: Text(
                      AppConstants.dropdownItems[index],
                      style: const TextStyle(color:Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
          },
        )
      ),
    );
  }
}
