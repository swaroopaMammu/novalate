import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:novalate/bloc/category_bloc.dart';
import 'package:novalate/utils/AppConstants.dart';
import 'package:novalate/utils/NavigationConstants.dart';

import '../widgets/round_corner_card.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  late final CategoryBloc cBloc;

  @override
  void initState() {
    super.initState();
    cBloc = CategoryBloc();
    cBloc.add(CategoryInitialLoadEvent());
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: cBloc,
        listenWhen: (prev,curr) => curr is CategoryActionState,
        buildWhen: (prev,current) => current is !CategoryActionState,
        builder: (context,state){
           return getSuccessUI();
        },
        listener: (context,state){
          if(state is CategoryCardClickState){
            context.push('${NavigationConstants.STORY_LIST}/${state.category}');
          }
        });
  }

  Widget getSuccessUI(){
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
                    cBloc.add(CategoryCardClickEvent(category: AppConstants.dropdownItems[index]));
                  },
                  child: RoundCornerCard(height:(index % 5 + 1) * 100,borderCorner: 8.0,
                  cardColor: const Color.fromARGB(255, 130, 151, 170), label: AppConstants.dropdownItems[index],
                    labelColor: Colors.white,
                  )
                );
            },
          )
      ),
    );
  }
}
