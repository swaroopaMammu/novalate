

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novalate/bloc/drafts_bloc.dart';
import 'package:novalate/models/data_model.dart';
import 'package:novalate/utils/firebase_fire_store.dart';

import '../../utils/AppConstants.dart';

class AddNewEntryScreen extends StatefulWidget {
  final bool isDraft;
  final String storyId;
  final DraftsBloc bloc;
  const AddNewEntryScreen({super.key,required this.isDraft, required this.storyId, required this.bloc});

  @override
  State<AddNewEntryScreen> createState() => _AddNewEntryScreenState();
}

class _AddNewEntryScreenState extends State<AddNewEntryScreen> {
  final _formKey = GlobalKey<FormState>();
   String? _selectedValue ;

  final _tController = TextEditingController();
  final _aController = TextEditingController();
  final _sController = TextEditingController();

  final db = DatabaseService();

  @override
  void dispose() {
    _tController.dispose();
    _aController.dispose();
    _sController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if(widget.isDraft){
      widget.bloc.add(DraftEditLoadEvent(storyId: widget.storyId));
    }else{
      widget.bloc.add(NewPostEntryLoadEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Post"),
        centerTitle: true,
      ),
      body: BlocConsumer<DraftsBloc,DraftsState>(
        bloc: widget.bloc,
        listenWhen: (prev,curr) => curr is DraftsActionState,
        buildWhen: (prev,current) => current is !DraftsActionState,
        listener: (BuildContext context, DraftsState state) {
          if(state is NewPostSubmitState){
            widget.bloc.add(DraftsListLoadEvent());
           Navigator.of(context).pop();
          }
        },
        builder: (context,state){
            switch(state.runtimeType){
              case DraftEditLoadSuccessState :
                return getSuccessUI(state);
              default : return getSuccessUI(state);
            }
        }
      )
    );
  }

  Widget getSuccessUI(DraftsState state){

    if(state is DraftEditLoadSuccessState){
      _selectedValue = state.story.category;
      _tController.text = state.story.title;
      _aController.text = state.story.author;
      _sController.text = state.story.story;
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            getTextInput(label: "Title",hint:"Enter title here",error: "Please enter your title",controller: _tController ),
            const SizedBox(height: 10),
            getTextInput(label: "Author",hint:"Enter Author name here",error: "Please enter your author name",controller: _aController ),
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
                      hint: const Text("Select a category"),
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
                controller: _sController,
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
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      final data = StoryModel(
                          _tController.text,
                          _aController.text,
                          _selectedValue ?? "",
                          "",
                          _sController.text,
                          true,
                          widget.storyId);
                      if(widget.isDraft){
                        widget.bloc.add(UpdateDraftSubmitEvent(story: data));
                      }else{
                        widget.bloc.add(NewPostSubmitEvent(story: data));
                      }

                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: const Text("Draft",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)))),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      final data = StoryModel(
                          _tController.text,
                          _aController.text,
                          _selectedValue ?? "",
                          "",
                          _sController.text,
                          false,
                          widget.storyId);
                      if (_formKey.currentState!.validate() &&
                          _selectedValue != "") {
                        if(widget.isDraft){
                          widget.bloc.add(UpdateDraftSubmitEvent(story: data));
                        }else{
                          widget.bloc.add(NewPostSubmitEvent(story: data));
                        }
                      } else {
                        if (_selectedValue == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select a category')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 32, 68, 114)),
                    child: const Text("Post",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)))),
          ],
        ),
      ),
    );
  }

  Widget getTextInput({required String label,required String hint,required String error, required TextEditingController controller}){
    return   TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(width: 2.0)
          )
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return error;
        }
        return null;
      },
      onSaved: (value) {

      },
    );
  }
}
