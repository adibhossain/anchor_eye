import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bcrypt/bcrypt.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String name, String phone, String pass) async {
    final CollectionReference uid_phone_pairs = FirebaseFirestore.instance.collection('uid_phone_pairs');
    await uid_phone_pairs.doc(uid).set({
      'phone': phone,
    });
    final salt = await BCrypt.gensalt();
    final hashpass = await BCrypt.hashpw(pass, salt);
    return await userCollection.doc(phone).set({
      'uid': uid,
      'name': name,
      'pass': hashpass,
      'bangla': true,
      'pi_ip': '',
    });
  }
}