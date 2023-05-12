import 'package:cloud_firestore/cloud_firestore.dart';

class Farmer {

  final String uid;
  String phone='',name='';
  bool bangla=true;

  Farmer({ required this.uid });
  void setOtherData() async {
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    final CollectionReference uid_phone_pairs = FirebaseFirestore.instance.collection('uid_phone_pairs');
    await uid_phone_pairs.doc(uid).get().then((documentSnapshot) {
      phone = documentSnapshot.get('phone');
    });
    await userCollection.doc(phone).get().then((documentSnapshot) {
      name = documentSnapshot.get('name');
      bangla = documentSnapshot.get('bangla');
    });
  }
}

class FarmerData {

  final String uid;


  FarmerData({ required this.uid});

}