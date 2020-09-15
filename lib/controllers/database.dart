import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String uid;
  final String urlid;
  DatabaseServices({this.uid,this.urlid});
  //collection references

  // ignore: deprecated_member_use
  final CollectionReference users = Firestore.instance.collection('users');
  Future updateUserData(String imgUrl, String email, String name, String phone,
   ) async {
    // ignore: deprecated_member_use
    return await users.document(uid).setData({
      'image': imgUrl,
      'email': email,
      'name': name,
      'phone': phone,
    });
  }


  Stream<QuerySnapshot> get user {
    return users.snapshots();
  }
}
