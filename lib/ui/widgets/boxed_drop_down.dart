import 'package:flutter/material.dart';

class BoxedDropDown extends StatelessWidget {
  final void Function(String? value) onSelect;
  final String? selectedValue;
  final List<String> dropDownList;
  const BoxedDropDown({super.key,required this.selectedValue,required this.onSelect, required this.dropDownList});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color:  const Color.fromARGB(
            255, 118, 113, 123), width: 1.0),
        // Border color and width
        borderRadius:
        BorderRadius.circular(8.0), // Rounded corners
      ),
      child: DropdownButton(
        underline: const SizedBox(),
        value: selectedValue,
        hint: const Text("Select a category"),
        items: dropDownList.map((String item){
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(), onChanged: (String? newValue) {
        onSelect(newValue);
      },),
    );
  }
}
