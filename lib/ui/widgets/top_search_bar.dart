import 'package:flutter/material.dart';

class TopSearchBar extends StatelessWidget {
  const TopSearchBar({super.key,required this.sController, required this.onSearch});
  final TextEditingController sController;
  final void Function(String query) onSearch;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: sController,
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
          onSearch(sController.text);
        }, icon: const Icon(Icons.search)),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
