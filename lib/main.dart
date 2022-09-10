import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messaging_in_firebase/models/FirebaseHelper.dart';
import 'package:messaging_in_firebase/models/UserModel.dart';
import 'package:messaging_in_firebase/pages/CompleteProfile.dart';
import 'package:messaging_in_firebase/pages/LoginPage.dart';
import 'package:messaging_in_firebase/pages/SignUpPage.dart';
import 'package:messaging_in_firebase/pages/home_page.dart';
import 'package:uuid/uuid.dart';
import 'firebase_options.dart';
var uuid = Uuid();


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

 User? currentUser = FirebaseAuth.instance.currentUser;
 
 if(currentUser != null){
  UserModel? thisUserModel = await FirebaseHelper.getUserModelById(currentUser.uid);
  if(thisUserModel != null){
      runApp( MyApplogin(userModel: thisUserModel, firebaseUser: currentUser));
  }
      
 }else{
   runApp(const MyApp());
}
 }
  

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginPage(),
    );
  }
}

class MyApplogin extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MyApplogin({super.key, required this.userModel, required this.firebaseUser});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home:HomePage(userModel: userModel, firebaseUser: firebaseUser),
    );
  }
}









