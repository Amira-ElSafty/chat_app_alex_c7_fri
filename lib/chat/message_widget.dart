import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_alex_c7_fri/model/message.dart';
import 'package:flutter_chat_app_alex_c7_fri/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget({required this.message});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.user?.id == message.senderId
        ? SentMessage(message: message)
        : RecieveMessage(message: message);
  }
}

class SentMessage extends StatelessWidget {
  Message message;
  SentMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          child: Text(message.content,
              style: TextStyle(color: Colors.white)
          ),
        ),
        Text(
          message.dateTime.toString(),
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }
}

class RecieveMessage extends StatelessWidget {
  Message message;
  RecieveMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message.dateTime.toString(),
          style: TextStyle(color: Colors.black),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          child: Text(message.content,
              style: TextStyle(color: Colors.black)
          ),
        ),
      ],
    );
  }
}
