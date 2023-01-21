import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app_alex_c7_fri/model/category.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/add_room/add_room_navigator.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/add_room/add_room_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_app_alex_c7_fri/utils.dart' as Utils;

class AddRoom extends StatefulWidget {
  static const String routeName = 'room';
  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNavigator {
  AddRoomViewModel viewModel = AddRoomViewModel();
  String roomTitle = '';
  String roomDescription = '';
  var formKey = GlobalKey<FormState>();
  var categoryList = Category.getCategory();
  late Category selectedItem;
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    selectedItem = categoryList[0];
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text('Add Room'),
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
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Create New Room',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Image.asset('assets/images/group.png'),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Enter Room Title'),
                        onChanged: (text) {
                          roomTitle = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter Room Title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton<Category>(
                                value: selectedItem,
                                items: categoryList
                                    .map((category) => DropdownMenuItem<Category>(
                                          value: category,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(category.title),
                                              Image.asset(category.image)
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (newCategory) {
                                  if (newCategory == null) return;
                                  selectedItem = newCategory;
                                  setState(() {});
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: 'Enter Room Description'),
                        maxLines: 4,
                        minLines: 4,
                        onChanged: (text) {
                          roomDescription = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter Room Description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            validateForm();
                          },
                          child: Text('Add Room')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      // add room
      viewModel.addRoom(roomTitle, roomDescription, selectedItem.id);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }
  @override
  void navigateToHome() {
    Timer(Duration(seconds: 2),(){
      Navigator.pop(context);
    });
  }


  @override
  void showLoading() {
    Utils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(message, context, 'OK', (context) {
      Navigator.pop(context);
    });
  }
}
