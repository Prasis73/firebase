
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nepsathi/Screen/feed.dart';
import 'package:nepsathi/Screen/signup.dart';
import 'package:nepsathi/widgets/button.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _auth = FirebaseAuth.instance;
  final _formKey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  String email="",password="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
              SizedBox(height: 10,),
              RoundButton(title: "Login",onPress: ()async{
                if(_formKey.currentState!.validate()){
                  try {
                    final user= await _auth.signInWithEmailAndPassword(email: email.toString().trim(), password: password.toString().trim());
                    if(user!=null){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>Feed()));
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
                Navigator.push(context, MaterialPageRoute(builder: (_)=>Register()));
              }, child: Text("Sign Up")),
              GestureDetector(
                  onLongPress: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Feed()));},
                  child: Text("By signing in You Agree our terms")),

            ],
          ),
        ),

        ),
      )
    );
  }
}
