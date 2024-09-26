import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/AppConstants.dart';

class AddNewEntryScreen extends StatefulWidget {
  const AddNewEntryScreen({super.key});

  @override
  State<AddNewEntryScreen> createState() => _AddNewEntryScreenState();
}

class _AddNewEntryScreenState extends State<AddNewEntryScreen> {
  final _formKey = GlobalKey<FormState>();
   String? _selectedValue ;


   Widget getTextInput({required String label,required String hint,required String error}){
     return   TextFormField(
       decoration: InputDecoration(
           labelText: "Title ",
           hintText: "Enter title here",
           border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(8.0),
               borderSide: const BorderSide(width: 2.0)
           )
       ),
       validator: (value) {
         if (value == null || value.isEmpty) {
           return "Please enter your title";
         }
         return null;
       },
       onSaved: (value) {

       },
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Post"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
              children: [
                getTextInput(label: "Title",hint:"Enter title here",error: "Please enter your title" ),
                const SizedBox(height: 10),
                getTextInput(label: "Author",hint:"Enter Author name here",error: "Please enter your author name" ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
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
                          value: _selectedValue,
                          hint: const Text("Select an option"),
                          items: AppConstants.dropdownItems.map((String item){
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                        }).toList(), onChanged: (String? newValue) {
                          setState(() {
                            _selectedValue = newValue ?? "";
                          });
                        },),
                      ),
                    ),

                    Expanded(
                      child: SizedBox(
                        height: 48,
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                        child: OutlinedButton(onPressed: (){},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 32, 68, 114),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                )
                            ),
                            child: const Text("Add Image",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16))),
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: "Enter content here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(width: 2.0)
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your  content";
                      }
                      return null;
                    },
                    onSaved: (value) {

                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){
                  context.pop();
                },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: Color.fromARGB(255, 32, 68, 114)
                    ),
                    child: const Text("Done",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)))),
              ],
          ),
        ),
      ),
    );
  }
}
