import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_alex_c7_fri/chat/chat_navigator.dart';
import 'package:flutter_chat_app_alex_c7_fri/chat/chat_screen_view_model.dart';
import 'package:flutter_chat_app_alex_c7_fri/chat/message_widget.dart';
import 'package:flutter_chat_app_alex_c7_fri/model/message.dart';
import 'package:flutter_chat_app_alex_c7_fri/model/room.dart';
import 'package:flutter_chat_app_alex_c7_fri/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_app_alex_c7_fri/utils.dart' as Utils;

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  ChatScreenViewModel viewModel = ChatScreenViewModel();
  String messageContent = '';
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = args;
    viewModel.currentUser = provider.user!;
    viewModel.listenForUpdateMessages();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          'assets/images/main_background.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(args.title),
            centerTitle: true,
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 32),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                  stream: viewModel.streamMessage,
                  builder: (context, asyncSnapShot) {
                    if (asyncSnapShot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (asyncSnapShot.hasError) {
                      return Text(asyncSnapShot.error.toString());
                    } else {
                      var messageList = asyncSnapShot.data?.docs
                              .map((doc) => doc.data())
                              .toList() ??
                          [];
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return MessageWidget(message: messageList[index]);
                        },
                        itemCount: messageList.length,
                      );
                    }
                  },
                )),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: controller,
                      onChanged: (text) {
                        messageContent = text;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(4),
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)))),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          viewModel.sendMessage(messageContent);
                        },
                        child: Row(
                          children: [
                            Text('Send'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.send_outlined)
                          ],
                        ))
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(message, context, 'OK', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void clearMessage() {
    controller.clear();
  }
}
