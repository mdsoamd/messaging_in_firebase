// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:messaging_in_firebase/main.dart';

class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilepic;


  UserModel({
     this.uid,
     this.fullname,
     this.email,
     this.profilepic,
  });
   
   UserModel.formMap(Map<String,dynamic>map){
      uid = map["uid"];
      fullname = map["fullname"];
      email = map["email"];
      profilepic = map["profilepic"];
   }

   Map<String,dynamic>toMap(){
    return {
        "uid":uid,
        "fullname":fullname,
        "email":email,
        "profilepic":profilepic
    };
   }
}
