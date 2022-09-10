import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_in_firebase/models/UserModel.dart';
import 'package:messaging_in_firebase/pages/CompleteProfile.dart';
import 'package:messaging_in_firebase/pages/SignUpPage.dart';
import 'package:messaging_in_firebase/pages/home_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

void checkValue(){
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if(email == ""|| password == ""){
    print("Pleas fill all the fields");
  }
  else{
     logIn(email, password);
  }
}

 void logIn(String email, String password)async{

     UserCredential? credential;
     
     try {
       credential = await FirebaseAuth.instance.signInWithEmailAndPassword
       (email: email, password: password);
     }on FirebaseAuthException catch (ex) {
       print(ex.code.toString());
     }

     if(credential != null){
        String uid = credential.user!.uid;

        DocumentSnapshot userData = await FirebaseFirestore.instance.
        collection("users").doc(uid).get();
        UserModel userModel = UserModel.formMap(userData.data() as
        Map<String,dynamic>
        );

        print("Log In Successful!");
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return HomePage(userModel: userModel, firebaseUser:credential!.user!);
        })));
     }
}
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 40
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [

                    Text("Chat App",style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 45,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email Address"
                      ),
                    ),
                     SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password"
                      ),
                      obscureText: true,
                    ),

                     SizedBox(
                      height: 25,
                    ),

                    CupertinoButton(
                       onPressed: (){
                        checkValue();
                        // Navigator.push(context,MaterialPageRoute(builder: ((context) => CompleteProfile())));
                       },
                       color: Theme.of(context).colorScheme.secondary,
                      child: Text("Log In"),)

                ],
              ),
            ),
          ),
        )),

        bottomNavigationBar: Container(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text("Don't have an account?",style: TextStyle(
                  fontSize: 16
                ),),

                 CupertinoButton(
                       onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: ((context) => SignUpPage())));
                       },
                      child: Text("Sign Up",style: TextStyle(
                        fontSize: 16
                      ),),)

            ],
          )
           ),
    );
  } 
}