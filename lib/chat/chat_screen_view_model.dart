import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_alex_c7_fri/chat/chat_navigator.dart';
import 'package:flutter_chat_app_alex_c7_fri/database/database_utils.dart';
import 'package:flutter_chat_app_alex_c7_fri/model/message.dart';
import 'package:flutter_chat_app_alex_c7_fri/model/my_user.dart';
import 'package:flutter_chat_app_alex_c7_fri/model/room.dart';

class ChatScreenViewModel extends ChangeNotifier{
  late ChatNavigator navigator ;
  late MyUser currentUser ;
  late Room room ;
  late Stream<QuerySnapshot<Message>> streamMessage ;
  void sendMessage(String content)async{
    Message message = Message(
        roomId: room.roomId,
        content: content,
        senderId: currentUser.id,
        senderName: currentUser.userName,
        dateTime: DateTime.now().millisecondsSinceEpoch);
    try{
      var res = await DatabaseUtils.insertMessage(message);
      // clear message
      navigator.clearMessage();
    }catch(error){
      navigator.showMessage(error.toString());
    }
  }
  void listenForUpdateMessages(){
   streamMessage =  DatabaseUtils.getMessagesFromFireStore(room.roomId);
  }
}