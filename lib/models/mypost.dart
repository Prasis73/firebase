

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Mypost extends StatefulWidget {
  const Mypost({Key? key}) : super(key: key);

  @override
  _MypostState createState() => _MypostState();
}

class _MypostState extends State<Mypost> {
  final dbRef=FirebaseDatabase.instance.reference().child('Posts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("app"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                scrollDirection: Axis.horizontal,
                  query: dbRef.child('Post List'),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                    return Column(
                      children: [
                        Text(snapshot.value!["pDescription"]),
                        Text(snapshot.value!["uEmail"]),
                        Container(
                          height: 200,
                          child: FadeInImage.assetNetwork(placeholder:"assets/download.png" ,
                            image: snapshot.value["pImage"],),
                        ),



                      ],
                    );
                  }),
            ),

          ],
        ),
      )
    );
  }
}
