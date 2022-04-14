import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static Future<String?> uploadFile(String dest, File file) async {
    try {
      UploadTask uploadFile = FirebaseStorage.instance.ref(dest).putFile(file);
      TaskSnapshot snapshot = await uploadFile;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> searchUsers(searchString) async {
    /* Remember to check for exceptions In case any error with getting snapshot */
    try {
      final QuerySnapshot allUsers =
          await FirebaseFirestore.instance.collection("UserData").get();

      /* Map List of DocumentSnapshot Objects to a List of key value pairs*/
      final allUsersMap = allUsers.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        return data;
      }).toList();

      /* Filter out matching users */
      return allUsersMap
          .where((user) => user["username"]
              .toLowerCase()
              .contains(searchString.toLowerCase()))
          .toList();
    } on FirebaseException catch (e) {
      print("Inside Firebase Api class");
      print(e.message);
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> returnAllUsers() async {
    final QuerySnapshot allUsers =
        await FirebaseFirestore.instance.collection("UserData").get();

    /* Map List of DocumentSnapshot Objects to a List of key value pairs*/
    return allUsers.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return data;
    }).toList();
  }

  static Future<String?> getChatID(emailUser1, emailUser2) async {
    /* Getting chat ID for messages */
    try {
      String chatID = "${emailUser1}_$emailUser2";
      var chat =
          await FirebaseFirestore.instance.collection("chat").doc(chatID).get();
      if (!chat.exists) {
        chatID = "${emailUser1}_$emailUser2";
        chat = await FirebaseFirestore.instance
            .collection("chat")
            .doc(chatID)
            .get();
      }
      return chatID;

      /* Get all messages for this user */
      // final Stream<QuerySnapshot> messages = FirebaseFirestore.instance
      //     .collection("messages")
      //     .where('chat_id', isEqualTo: chatID)
      //     .orderBy('sent_at')
      //     .snapshots();
      // messages
    } on Exception catch (e) {
      print("Error occured while getting chatID");
      print(e);
      return null;
    }
  }
}
