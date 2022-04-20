import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:nepsathi/Screen/addpost.dart';
import 'package:nepsathi/Screen/addstory.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final dbRef=FirebaseDatabase.instance.reference().child('Posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("NepSathi",style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue
                    ),),
                    SizedBox(width: 120,),
                    Icon(Icons.search),
                    Icon(Icons.waves),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.home),
                    Icon(Icons.supervised_user_circle),
                    Icon(Icons.message_outlined),
                    Icon(Icons.notifications_outlined),
                    Icon(Icons.video_collection_outlined),
                  ],
                ),
              ),
            ),
             SizedBox(height: 5,),
             Container(
              child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.supervised_user_circle_rounded),
                   ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPost()));
                    },
                    child: Material(
                     borderRadius: BorderRadius.circular(30),
                      color: Colors.grey,
                      child: Container(
                        height: 50,
                        width: 270,
                        child: Center(child: Text("What's on your mind?")),
                      ),
                    ),
                  ),
                  Column(children: [
                    Icon(Icons.insert_photo_outlined),
                    Text("Photo")
                  ],)
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStory()));
                    } ,child: Material(borderRadius: BorderRadius.circular(8),color: Colors.blue,child: Container(width: 100,height: 120,child: Column(children: [Icon(Icons.supervised_user_circle_rounded,size: 100,),Text("Add to Story +",style: TextStyle(fontWeight: FontWeight.bold),)],),))),SizedBox(width: 5,),
                    Material(borderRadius: BorderRadius.circular(8),color: Colors.redAccent,child: Container(width: 100,height: 120,)),SizedBox(width: 5,),
                    Material(borderRadius: BorderRadius.circular(8),color: Colors.green,child: Container(width: 100,height: 120,)),SizedBox(width: 5,),
                    Material(borderRadius: BorderRadius.circular(8),color: Colors.yellow,child: Container(width: 100,height: 120,)),SizedBox(width: 5,),
                    Material(borderRadius: BorderRadius.circular(8),color: Colors.pinkAccent,child: Container(width: 100,height: 120,)),SizedBox(width: 5,),
                    Material(borderRadius: BorderRadius.circular(8),color: Colors.orange,child: Container(width: 100,height: 120,)),SizedBox(width: 5,),
                    Material(borderRadius: BorderRadius.circular(8),color: Colors.red,child: Container(width: 100,height: 120,)),SizedBox(width: 5,),
                    Material(borderRadius: BorderRadius.circular(8),color: Colors.blueGrey,child: Container(width: 100,height: 120,)),SizedBox(width: 5,),
                    Material(borderRadius: BorderRadius.circular(8),color: Colors.lightBlueAccent,child: Container(width: 100,height: 120,)),SizedBox(width: 5,),
                    Material(borderRadius: BorderRadius.circular(8),color: Colors.greenAccent,child: Container(width: 100,height: 120,)),SizedBox(width: 5,),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(height: 400,width: 600,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        CircleAvatar(backgroundColor: Colors.red,),SizedBox(width: 10,),
                        Column(children:[Text("Prasis Rijal",style: TextStyle(fontWeight: FontWeight.bold)),Text("45 min",style: TextStyle(color: Colors.white70))],),
                      ],),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Hello Users, this is my profile picture. Hope you like it or comment here. Also do share with your friends"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            color: Colors.red,
                            width: 600,
                            child: Icon(Icons.supervised_user_circle_outlined,size: 240,)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Material(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey,
                            child: Container(
                              height: 40,
                              width: 100,
                              child: Icon(Icons.favorite_outline),
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey,
                            child: Container(
                              height: 40,
                              width: 100,

                              child: Icon(Icons.comment_bank_outlined),
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey,
                            child: Container(
                              height: 40,
                              width: 100,
                              child: Icon(Icons.share),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),),
                  Divider(),
                  Container(height: 400,width: 600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: FirebaseAnimatedList(
                            query: dbRef.child('Post List'),
                            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                              return Column(
                                children: [
                                  FadeInImage.assetNetwork(placeholder:"assets/download.png" ,
                                      image: snapshot.value["pImage"]),
                                  Text("Hello",style: TextStyle(fontSize: 500),),
                                ],
                              );
                            })
                        ),
                        Row(children: [
                          CircleAvatar(backgroundColor: Colors.red,),SizedBox(width: 10,),
                          Column(children:[Text("Prasis Rijal",style: TextStyle(fontWeight: FontWeight.bold)),Text("45 min",style: TextStyle(color: Colors.white70))],),
                        ],),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Hello Users, this is my profile picture. Hope you like it or comment here. Also do share with your friends"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              color: Colors.red,
                              width: 600,
                              child: Icon(Icons.supervised_user_circle_outlined,size: 240,)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,
                                child: Icon(Icons.favorite_outline),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,

                                child: Icon(Icons.comment_bank_outlined),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,
                                child: Icon(Icons.share),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),),
                  Divider(),
                  Container(height: 400,width: 600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          CircleAvatar(backgroundColor: Colors.red,),SizedBox(width: 10,),
                          Column(children:[Text("Prasis Rijal",style: TextStyle(fontWeight: FontWeight.bold)),Text("45 min",style: TextStyle(color: Colors.white70))],),
                        ],),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Hello Users, this is my profile picture. Hope you like it or comment here. Also do share with your friends"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              color: Colors.red,
                              width: 600,
                              child: Icon(Icons.supervised_user_circle_outlined,size: 240,)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,
                                child: Icon(Icons.favorite_outline),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,

                                child: Icon(Icons.comment_bank_outlined),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,
                                child: Icon(Icons.share),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),),
                  Divider(),
                  Container(height: 400,width: 600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          CircleAvatar(backgroundColor: Colors.red,),SizedBox(width: 10,),
                          Column(children:[Text("Prasis Rijal",style: TextStyle(fontWeight: FontWeight.bold)),Text("45 min",style: TextStyle(color: Colors.white70))],),
                        ],),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Hello Users, this is my profile picture. Hope you like it or comment here. Also do share with your friends"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              color: Colors.red,
                              width: 600,
                              child: Icon(Icons.supervised_user_circle_outlined,size: 240,)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,
                                child: Icon(Icons.favorite_outline),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,

                                child: Icon(Icons.comment_bank_outlined),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,
                                child: Icon(Icons.share),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),),
                  Divider(),
                  Container(height: 400,width: 600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          CircleAvatar(backgroundColor: Colors.red,),SizedBox(width: 10,),
                          Column(children:[Text("Prasis Rijal",style: TextStyle(fontWeight: FontWeight.bold)),Text("45 min",style: TextStyle(color: Colors.white70))],),
                        ],),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Hello Users, this is my profile picture. Hope you like it or comment here. Also do share with your friends"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              color: Colors.red,
                              width: 600,
                              child: Icon(Icons.supervised_user_circle_outlined,size: 240,)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,
                                child: Icon(Icons.favorite_outline),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,

                                child: Icon(Icons.comment_bank_outlined),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              child: Container(
                                height: 40,
                                width: 100,
                                child: Icon(Icons.share),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),),
                  Divider(),


                ],
              ),
            )

          ],
        ),
      ),
    ));
  }
}
