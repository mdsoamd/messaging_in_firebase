import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_in_firebase/models/UserModel.dart';
import 'package:messaging_in_firebase/pages/CompleteProfile.dart';
import 'package:messaging_in_firebase/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void checkValues(){
    String email =emailController.text.trim();
    String password=passwordController.text.trim();
    String cPassword=cPasswordController.text.trim();

    if(email == "" || password == "" || cPassword ==""){
      print("Pleas fill all the fields");
    }
    else if(password != cPassword){
        print("passwords do not match!");
    }else{
      signUp(email, password);
      print("Sign Up Successful!");
    }
  }



  void signUp(String email,String password) async {
    UserCredential? credential;

    try {
       credential = await FirebaseAuth.instance.
       createUserWithEmailAndPassword(email: email, password: password);

    }on FirebaseAuthException catch (ex) {
      print(ex.code.toString());
    }



    if(credential != null){
        String uid = credential.user!.uid;
        UserModel newUser = UserModel(
          uid: uid,
          fullname: "",
          email: email,
          profilepic: ""
          );

        await FirebaseFirestore.instance.collection("users").doc(uid).set
        (newUser.toMap()).then((value) {
          print("New User Created!");
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return CompleteProfile(userModel: newUser, firebaseUser: credential!.user!);
          })));
        } );
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
                      height: 10,
                    ),
                    TextField(
                      controller: cPasswordController,
                      decoration: InputDecoration(
                        labelText: "Confirm Password"
                      ),
                      obscureText: true,
                    ),

                     SizedBox(
                      height: 25,
                    ),

                    CupertinoButton(
                       onPressed: (){
                        checkValues();
                       },
                       color: Theme.of(context).colorScheme.secondary,
                      child: Text("Sign Up"),)

                ],
              ),
            ),
          ),
        )),
        
        bottomNavigationBar: Container(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text("Already have an account?",style: TextStyle(
                  fontSize: 16
                ),),

                 CupertinoButton(
                       onPressed: (){
                         Navigator.pop(context);
                       },
                      child: Text("Log in",style: TextStyle(
                        fontSize: 16
                      ),),)

            ],
          )
           ),
    );
  } 
}