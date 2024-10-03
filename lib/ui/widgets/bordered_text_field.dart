import 'package:flutter/material.dart';

class BorderedTextField extends StatelessWidget {
  const BorderedTextField({super.key,required this.hint,required this.label,
    required this.error,required this.controller,required this.isLongTextField});
  final String hint;
  final String? label;
  final String error;
  final bool isLongTextField;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return isLongTextField
        ? TextFormField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            textAlignVertical: TextAlignVertical.top,
            expands: true,
            maxLines: null,
            decoration: getFieldDecoration(hint, label),
            validator: (value) {
              if ((value == null || value.isEmpty)) {
                return error;
              }
              return null;
            },
            onSaved: (value) {})
        : TextFormField(
            controller: controller,
            decoration: getFieldDecoration(hint, label),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return error;
              }
              return null;
            },
            onSaved: (value) {},
          );
  }

  InputDecoration getFieldDecoration( String hint, String? label){
    return InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: 2.0)
        )
    );
  }
}
