import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String? displayName;
  String? email;
  String? photoUrl;

  UserModel({required this.uid, this.displayName, this.email, this.photoUrl});

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    String displayName = data['displayName'];
    String email = data['email'];
    String photoUrl = data['photoUrl'];

    return UserModel(
        uid: documentId,
        displayName: displayName,
        email: email,
        photoUrl: photoUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl
    };
  }
}
