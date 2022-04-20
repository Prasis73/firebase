

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nepsathi/Screen/signin.dart';

import '../widgets/button.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  final _formKey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController usernameController=TextEditingController();
  String email="",password="",username="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Container(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "email",
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder()
                    ),
                    onChanged: (String value){
                      email=value;
                    },
                    validator: (value){
                      return value!.isEmpty? "enter email":null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "password",
                          labelText: "password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder()
                      ),
                      onChanged: (String value){
                        password=value;
                      },
                      validator: (value){
                        return value!.isEmpty? "enter email":null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.emailAddress,

                      decoration: InputDecoration(
                          hintText: "username",
                          labelText: "username",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder()
                      ),
                      onChanged: (String value){
                        username=value;
                      },
                      validator: (value){
                        return value!.isEmpty? "enter email":null;
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  RoundButton(title: "Register",onPress: ()async{
                    if(_formKey.currentState!.validate()){

                      try {
                        final user= await _auth.createUserWithEmailAndPassword(email: email.toString().trim(), password: password.toString().trim());
                        
                        if(user!=null){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>Signin()));
                        }

                      }on FirebaseAuthException catch(error){
                        print(error.toString());

                      }
                    }
                    else{
                      print('fail');
                    }

                  },),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Signin()));
                  }, child: Text("Already have an Account?"))


                ],
              ),
            ),

          ),
        )
    );
  }
}
