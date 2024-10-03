
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:novalate/bloc/drafts_bloc.dart';
import 'package:novalate/models/data_model.dart';
import 'package:novalate/utils/firebase_fire_store.dart';

import '../../utils/AppConstants.dart';

class AddNewEntryScreen extends StatefulWidget {
  final bool isDraft;
  final String storyId;
  const AddNewEntryScreen({super.key,required this.isDraft, required this.storyId});

  @override
  State<AddNewEntryScreen> createState() => _AddNewEntryScreenState();
}

class _AddNewEntryScreenState extends State<AddNewEntryScreen> {

  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _tController;
  late final TextEditingController _aController;
  late final TextEditingController _sController;
  late bool _isButtonEnabled;
  late final DatabaseService db;
  late DraftsBloc dBloc;
  String? _selectedValue ;
  File? imageFile;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _tController = TextEditingController();
    _aController = TextEditingController();
    _sController = TextEditingController();
    _isButtonEnabled = true;
    dBloc = DraftsBloc();
    db = DatabaseService();

    if(widget.isDraft){
      dBloc.add(DraftEditLoadEvent(storyId: widget.storyId));
    }else{
      dBloc.add(NewPostEntryLoadEvent());
    }
    super.initState();
  }

  @override
  void dispose() {
    _tController.dispose();
    _aController.dispose();
    _sController.dispose();
    super.dispose();
  }

  Future<void> getImageFromGallery() async{
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(img != null){
        imageFile = File(img.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.NEW_POST),
        centerTitle: true,
      ),
      body: BlocConsumer<DraftsBloc,DraftsState>(
        bloc: dBloc,
        listenWhen: (prev,curr) => curr is DraftsActionState,
        buildWhen: (prev,current) => current is !DraftsActionState,
        listener: (BuildContext context, DraftsState state) {
          if(state is NewPostSubmitState){
            _isButtonEnabled = true;
           Navigator.of(context).pop();
          }
          if(state is DraftAddImageButtonClickState){
            getImageFromGallery();
          }
          if(state is CategoryOptionState){
            _selectedValue = state.option;
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
            getCategoryAndImage(),
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
                      if(_isButtonEnabled){
                        final data = StoryModel(
                            _tController.text,
                            _aController.text,
                            _selectedValue ?? "",
                            "",
                            _sController.text,
                            true,
                            widget.storyId);
                        validateFieldsForDraft(data);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: _isButtonEnabled? Text("Draft",
                        style: TextStyle(
                            color:_isButtonEnabled? Colors.black : Colors.grey ,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)) : CircularProgressIndicator())),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if(_isButtonEnabled){
                        final data = StoryModel(
                            _tController.text,
                            _aController.text,
                            _selectedValue ?? "",
                            "",
                            _sController.text,
                            false,
                            widget.storyId);
                        validateFieldsForPost(data);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 32, 68, 114)),
                    child: _isButtonEnabled? Text("Post",
                        style:  TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16) ): CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }


  validateFieldsForDraft(StoryModel data){
    if (_selectedValue == null || _tController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Category or title can not be blank')),
      );
    } else {
      if (widget.isDraft) {
        dBloc.add(UpdateDraftSubmitEvent(
            story: data, imageUrl: imageFile));
      } else {
        dBloc.add(NewPostSubmitEvent(
            story: data, imageUrl: imageFile));
      }
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  validateFieldsForPost(StoryModel data){
    if(_selectedValue == null || _selectedValue == "" || imageFile == null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a category and image')),
      );
    } else if(_formKey.currentState!.validate()) {
      if (widget.isDraft ) {
        dBloc.add(
            UpdateDraftSubmitEvent(story: data, imageUrl: imageFile));
      } else {
        dBloc.add(NewPostSubmitEvent(story: data, imageUrl: imageFile));
      }
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  Widget getCategoryAndImage(){
    return   Row(
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
              dBloc.add(SelectCategoryOption(option: newValue??""));
            },),
          ),
        ),

        Expanded(
          child: SizedBox(
              height: 48,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                child: OutlinedButton(onPressed: (){
                  dBloc.add(AddImageButtonClickEvent());
                },
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
        if((value == null || value.isEmpty)) {
          return error;
        }
        return null;
      },
      onSaved: (value) {

      },
    );
  }
}
