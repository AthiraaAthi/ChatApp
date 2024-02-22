import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // get instance of  firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get user stream

  /*
  List<Map<String,dynamic>> = 

  [ list of maps
    {
    "email": test@gmail.com,
    "id": ..
  },
   {
    "email": email@gmail.com,
    "id": ..
  },
  ]
  */
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return firestore.collection("Users").snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          //go through individual user
          final user = doc.data();
          //return user
          return user;
        }).toList();
      },
    );
  }

  // send messages

  //get messages
}
