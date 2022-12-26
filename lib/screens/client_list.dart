import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rolebased/widgets/dish_element.dart';

import '../model/food.dart';
import '../register.dart';
import '../repository/food_repo.dart';
import 'fav_list.dart';

class ClientList extends StatefulWidget {
  const ClientList({super.key});

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  @override
  Widget build(BuildContext context) {
    final ctrUpdateNameFood = TextEditingController();
    final ctrUpdateImageUrl = TextEditingController();
    bool heartFavorite = false;
    List<Food> allFoods = [];
    bool exist = false;

    @override
    initState() {
      heartFavorite = false;
      super.initState();
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      //collect data from firebase collection foods, StreamBuilder is in sync with the app
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('foods')
            .orderBy('foodName')
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
            allFoods = snp.data!.docs
                .map((doc) => Food.fromJson(doc.data() as Map<String, dynamic>))
                .toList();
            return ListView.builder(
                itemCount: allFoods.length,
                itemBuilder: (context, index) {
                  return DishElement(
                    food: allFoods[index],
                    isFavorite: FavoriteList.favpr
                        .map((e) => e.id)
                        .toList()
                        .contains(allFoods[index].id),
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
