// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_in_firebase/main.dart';
import 'package:messaging_in_firebase/models/ChatRoomModel.dart';

import 'package:messaging_in_firebase/models/UserModel.dart';
import 'package:messaging_in_firebase/pages/ChatRoomPage.dart';

class SearchPage extends StatefulWidget {
  UserModel userModel;
  User firebaseUser;
   SearchPage({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);
  
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController searchController = TextEditingController();

 Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("chatrooms").where("participants.${widget.userModel.uid}", isEqualTo: true).where("participants.${targetUser.uid}", isEqualTo: true).get();

    if(snapshot.docs.length > 0) {
      // Fetch the existing one
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom = ChatRoomModel.formMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
    }
    else {
      // Create a new one
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        participants: {
          widget.userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
      );

      await FirebaseFirestore.instance.collection("chatrooms").doc(newChatroom.chatroomid).set(newChatroom.toMap());

      chatRoom = newChatroom;

      log("New Chatroom Created!");
    }

    return chatRoom;
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        
        child: Column(children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: "Search"
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(child: Text("Search"),
          color: Theme.of(context).colorScheme.secondary,
           onPressed: (){
            setState(() {
              
            });
           }),

             SizedBox(
            height: 20,
          ),

          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").where
            ("email",isEqualTo: searchController.text).where("email",isNotEqualTo: widget.userModel.email).snapshots(),
            builder: ((context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active){
                  if(snapshot.hasData){
                    QuerySnapshot dataSnapshot = snapshot.data as 
                    QuerySnapshot;
                    
                    if(dataSnapshot.docs.length>0){
                        Map<String,dynamic> userMap = dataSnapshot.docs[0].data()
                    as Map<String,dynamic>;

                    UserModel searchedUser = UserModel.formMap(userMap);

                    return ListTile(
                      onTap: () async{
                      ChatRoomModel? chatroomModel = await getChatroomModel(searchedUser);

                            if(chatroomModel != null) {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ChatRoomPage(
                                    targetUser: searchedUser,
                                    userModel: widget.userModel,
                                    firebaseUser: widget.firebaseUser,
                                    chatroom: chatroomModel,
                                  );
                                }
                              ));
                            }
                        
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(searchedUser.profilepic!),
                        backgroundColor: Colors.grey[500],
                      ),
                      title: Text(searchedUser.fullname!),
                      subtitle: Text(searchedUser.email!),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    );
                    }else{
                      return  Text("No results found!");
                    }
                    
                  }
                  else if(snapshot.hasError){
                      return Text("An error occured!");
                  }
                  else{
                    return Text("No results found!");
                  }
              }
              else{
                return CircularProgressIndicator();
              }
            }),
          )
           
        ]),
      ),
    );
  }
}