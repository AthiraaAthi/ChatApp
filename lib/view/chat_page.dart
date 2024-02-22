import 'package:chat_app_fb/components/my_textfields.dart';
import 'package:chat_app_fb/services/auth/auth_service.dart';
import 'package:chat_app_fb/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});
  //text controller
  final TextEditingController messagecontroller = TextEditingController();

  //chat and auth services
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  //send messages
  void sendMessage() async {
    //if there is something inside the textfield
    if (messagecontroller.text.isNotEmpty) {
      //send the msg
      await chatService.sendMessage(receiverID, messagecontroller.text);
      //clear text controller
      messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //display all the msgs
          Expanded(child: buildMessagesList()),
          //user input
          buildUserInput()
        ],
      ),
    );
  }

  //build message list
  Widget buildMessagesList() {
    String senderID = authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        //errors
        if (snapshot.hasError) {
          return Text("Error");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }
        //return listview
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build message item
  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data["senderID "] == authService.getCurrentUser()!.uid;

    //align msg to the right if sender is the current user,otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(data["message"]),
          ],
        ));
  }

  //build message input
  Widget buildUserInput() {
    return Row(
      children: [
        //txtfield should take upmost of the space
        Expanded(
          child: MyTextFields(
              hintText: "Type a message",
              obscure: false,
              controller: messagecontroller),
        ),

        //send button
        IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward))
      ],
    );
  }
}
