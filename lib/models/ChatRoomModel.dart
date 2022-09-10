// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatRoomModel {
  String? chatroomid;
  Map<String,dynamic>? participants;
  String? lastMessage;

  ChatRoomModel({
    this.chatroomid,
    this.participants,
    this.lastMessage
  });

  ChatRoomModel.formMap(Map<String,dynamic>map){
    chatroomid = map["chatroomid"];
    participants = map["participants"];
  }

  Map<String,dynamic>toMap(){
    return{
      "chatroomid":chatroomid,
      "participants":participants,
      "lastMessage":lastMessage
    };
  }

  
}
