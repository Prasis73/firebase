
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final title;
  final VoidCallback onPress;
  const RoundButton({Key? key,required this.title,required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: MaterialButton(onPressed: onPress,
      height: 40,
       child: Text(title,style: TextStyle(color: Colors.white),),
       color: Colors.redAccent,
    ),);
  }
}
