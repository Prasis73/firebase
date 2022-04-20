

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/button.dart';

class AddStory extends StatefulWidget {
  const AddStory({Key? key}) : super(key: key);

  @override
  _AddStoryState createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  final postRef= FirebaseDatabase.instance.reference().child("Posts");
  //firebase_storage.FirebaseStorage storage= firebase_storage.FirebaseStorage.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth _auth=FirebaseAuth.instance;
  File? _image;
  final picker= ImagePicker();
  TextEditingController titleController= TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  Future getImageGallery()async{
    final pickFile=await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pickFile!=null){
        _image=File(pickFile.path);
      }
      else{
        print("no image selected");
      }
    });
  }

  Future getImageCamera()async{
    final pickFile=await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if(pickFile!=null){
        _image=File(pickFile.path);
      }
      else{
        print("no image captured");
      }
    });
  }

  void dialog(context){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      getImageCamera();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Camera"),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.photo_album),
                      title: Text("Gallery"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Story"),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: (){
                dialog(context);
              },
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height*.2,
                  width: MediaQuery.of(context).size.width*1,
                  child: _image!=null? ClipRRect(
                    child: Image.file(_image!.absolute,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fitHeight,),
                  ):Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 100,
                    height: 100,
                    child: Icon(Icons.image,color: Colors.blue,),

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLength: 10,
                decoration: InputDecoration(
                    labelText: "UserName",
                    border: OutlineInputBorder(),
                    hintText:"Enter Name",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                    hintText:"Enter Description",
                    hintStyle: TextStyle(color: Colors.grey,)
                ),
              ),
            ),
            RoundButton(title:"Upload", onPress: ()async{
              setState(() {

              });
              try {
                int date = DateTime
                    .now()
                    .microsecondsSinceEpoch;
                Reference ref = FirebaseStorage.instance.ref("/storyimage/blogapp$date");
                UploadTask uploadTask = ref.putFile(_image!.absolute);
                await Future.value(uploadTask);
                var newUrl = await ref.getDownloadURL();
                final User? user= _auth.currentUser;
                postRef.child("Story List").child(date.toString()).set({
                  'pId': date.toString(),
                  'pImage': newUrl.toString(),
                  'pTime': date.toString(),
                  'pTitle': titleController.text.toString(),
                  'pDescription': descriptionController.text.toString(),
                  'uEmail': user!.email.toString(),
                  'uId': user.uid.toString(),
                }).then((value) {
                  print("published");
                }).onError((error, stackTrace) {
                  print(error);
                });
              }catch(e){

              }
            })
          ],
        ),
      ) ,
    );
  }
}
