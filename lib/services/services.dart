import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kofee_with_code/models/brew.dart';
class databaseService{

  final String uid;
  databaseService({required this.uid});
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('coffee');

  Future updateUserData(String sugars,String name,int strength)async{
    return await brewCollection.doc(uid).set({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength,
      
    });
  }
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
  return snapshot.docs.map((doc){
      return Brew(
        name: doc.get("name") ?? '',
        strength: doc.get('strength') ?? 0,
        sugars: doc.get('sugars') ?? '0',
      );
  }).toList();
}
  Stream<List<Brew>> get coffee{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

}
