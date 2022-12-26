import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/food.dart';

Future addFood(Food food) async {
  //create a doc in DB firebase
  final docFood = FirebaseFirestore.instance.collection("foods").doc();
  //the param food will get the firebase generated id
  food.id = docFood.id;
  //saving data
  await docFood.set(food.toJson());
}

//////////// Update methode

Future updateFood(Food food) async {
  //choose the doc to update
  final docFood = FirebaseFirestore.instance.collection("foods").doc(food.id);
  //saving data
  await docFood.update(food.toJson());
}

////////////// delete food
Future deleteFood(String id) async {
  final docFood = FirebaseFirestore.instance.collection("foods").doc(id);
  await docFood.delete();
}

Future deleteFavorite(String id, String userId) async {
  var collection = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('UserFav');
  var snapshot = await collection.where('id', isEqualTo: id).get();
  for (var doc in snapshot.docs) {
    await doc.reference.delete();
  }
}
