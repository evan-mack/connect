import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/models/user_model.dart';
import 'package:connect/services/firestore_path.dart';
import 'package:connect/services/firestore_service.dart';

class FirestoreDatabase {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _firestoreService = FirestoreService.instance;

  Future<void> addNewUser(Map<String, dynamic> userInfoMap) async {
    _firestoreService.set(path: FirestorePath.users(uid), data: userInfoMap);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getCurrentUser(String uuid) {
    print('firestore database $uuid');
    final path = FirestorePath.users(uuid);
    final reference = FirebaseFirestore.instance.doc(path);
    return reference.get();
  }
}
