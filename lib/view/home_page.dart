import 'package:chat_app_fb/services/auth/auth_service.dart';
import 'package:chat_app_fb/components/my_drawer.dart';
import 'package:chat_app_fb/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat & auth services
  final ChatService ChatServices = ChatService();
  final AuthService AuthServices = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      drawer: MyDrawer(),
      body: buildUserList(),
    );
  }

  // build a list of uses except for the current logged-in user
  Widget buildUserList() {
    return StreamBuilder(
      stream: ChatServices.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return Text("Error");
        }

        // loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("loading..");
        }

        // return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // build individual list tile for user
  Widget buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
    if (userData["email"] != AuthServices.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          // tapped on a user => go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverID: userData["uid"],
                  receiverEmail: userData["email"],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
