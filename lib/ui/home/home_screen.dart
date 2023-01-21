import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_alex_c7_fri/database/database_utils.dart';
import 'package:flutter_chat_app_alex_c7_fri/model/room.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/add_room/add_room.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/add_room/room_widget.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/home/home_navigator.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNavigator{
  HomeViewModel viewModel = HomeViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
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
            title: Text('Home'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).pushNamed(AddRoom.routeName);
            },
            child: Icon(Icons.add),
          ),
          body: StreamBuilder<QuerySnapshot<Room>>(
            stream:DatabaseUtils.getRooms() ,
            builder:(context,asyncSnapShot){
              if(asyncSnapShot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              } else if(asyncSnapShot.hasError){
                return Text(asyncSnapShot.error.toString());
              }else {
                // has data
                var roomsList = asyncSnapShot.data?.docs.map((doc) =>
                doc.data()).toList() ?? [];
                return GridView.builder(
                  itemBuilder: (context,index){
                    return RoomWidget(room: roomsList[index],);
                  },
                    itemCount: roomsList.length ,
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8
                    ) );
              }
            } ,
          ),
        ),

      ]),
    );
  }
}
