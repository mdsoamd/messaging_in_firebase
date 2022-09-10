// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  String? messageid;
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdon;


  MessageModel({
    this.messageid,
    this.sender,
    this.text,
    this.seen,
    this.createdon,
   
  });

  MessageModel.formMap(Map<String,dynamic>map){
    messageid = map["messageif"];
    sender = map["sender"];
    text = map["text"];
    seen = map["seen"];
    createdon = map["createdon"];

  }

  Map<String,dynamic>toMap(){
    return{
        "messageid":messageid,
        "sender":sender,
        "text":text,
        "seen":seen,
        "createdon":createdon,
    };
  }
}
