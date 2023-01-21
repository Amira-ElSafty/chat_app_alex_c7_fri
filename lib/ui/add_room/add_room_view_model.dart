import 'package:flutter/material.dart';
import 'package:flutter_chat_app_alex_c7_fri/database/database_utils.dart';
import 'package:flutter_chat_app_alex_c7_fri/model/room.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/add_room/add_room_navigator.dart';

class AddRoomViewModel extends ChangeNotifier{
  late AddRoomNavigator navigator ;

  void addRoom(String roomTitle , String roomDescription , String categoryId)async{

    Room room = Room(
        roomId: "",
        title: roomTitle,
        description: roomDescription,
        categoryId: categoryId);
    try{
      navigator.showLoading();
      var createdRoom = await DatabaseUtils.addRoomToFireStore(room);
      navigator.hideLoading();
      navigator.showMessage('Room was added successfully');
      navigator.navigateToHome();
    }catch(e){
      navigator.hideLoading();
      navigator.showMessage(e.toString());
    }

  }

}