import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/food.dart';
import '../register.dart';
import '../repository/food_repo.dart';
import 'client_list.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});
  static List<Food> favpr = [];
  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    List<Food> favFood = [];

    return Scaffold(
      //collect data from firebase collection foods, StreamBuilder is in sync with the app
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(returnUserId())
            .collection('UserFav')
            .get(),
        builder: (context, snp) {
          // if error
          if (snp.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          // if snapshot has data or empty
          if (snp.hasData) {
            //create a list of object from json firebase then convert it to list
            favFood = snp.data!.docs
                .map((doc) => Food.fromJson(doc.data() as Map<String, dynamic>))
                .toList();

            FavoriteList.favpr = favFood;

            return ListView.builder(
                itemCount: favFood.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.0),
                            topLeft: Radius.circular(
                                15.0)), // to add radius for the image we need ClipRRect
                        child: Image.network(
                          favFood[index].imageUrl,
                          height: 250,
                          width: double.infinity, // all the width
                          fit: BoxFit.cover, //cover all the container
                        ),
                      ),
                      Container(
                        color: Color.fromARGB(255, 0, 0, 0),
                        alignment: Alignment.center, //centred text
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              favFood[index].foodName,
                              style: TextStyle(
                                fontSize: 30,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 234, 83, 83),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                });
          } else {
            Center(child: CircularProgressIndicator());
          }

          return Text('');
        },
      ),
    );
  }
}
