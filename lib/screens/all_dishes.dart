import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/food.dart';
import '../repository/food_repo.dart';

class AllDishes extends StatefulWidget {
  const AllDishes({super.key});

  @override
  State<AllDishes> createState() => _AllDishesState();
}

class _AllDishesState extends State<AllDishes> {
  @override
  Widget build(BuildContext context) {
    final ctrUpdateNameFood = TextEditingController();
    final ctrUpdateImageUrl = TextEditingController();

    List<Food> allFoods = [];
    return Scaffold(
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
                          allFoods[index].imageUrl,
                          height: 250,
                          width: double.infinity, // all the width
                          fit: BoxFit.cover, //cover all the container
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        alignment: Alignment.center, //centred text
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 40),
                            Text(
                              allFoods[index].foodName,
                              style: TextStyle(
                                fontSize: 30,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      ctrUpdateNameFood.text =
                                          allFoods[index].foodName;
                                      ctrUpdateImageUrl.text =
                                          allFoods[index].imageUrl;
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    'Update :  ${allFoods[index].foodName}'),
                                                content: SingleChildScrollView(
                                                  child: Container(
                                                    height: 250,
                                                    width: 450,
                                                    child: Column(
                                                      children: [
                                                        TextField(
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "Food Name : ",
                                                          ),
                                                          controller:
                                                              ctrUpdateNameFood,
                                                        ),
                                                        SizedBox(height: 10),
                                                        TextField(
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "Image Url : ",
                                                          ),
                                                          controller:
                                                              ctrUpdateImageUrl,
                                                        ),
                                                        SizedBox(height: 10),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                Colors.black,
                                                          ),
                                                          onPressed: () {
                                                            final food = (Food(
                                                                id: allFoods[
                                                                        index]
                                                                    .id,
                                                                foodName:
                                                                    ctrUpdateNameFood
                                                                        .text,
                                                                imageUrl:
                                                                    ctrUpdateImageUrl
                                                                        .text));

                                                            if (ctrUpdateNameFood
                                                                    .text
                                                                    .isNotEmpty &&
                                                                ctrUpdateImageUrl
                                                                    .text
                                                                    .isNotEmpty) {
                                                              updateFood(food);
                                                              setState(() {});
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          },
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                Text('Update'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.orange,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Annuler');
                                                      },
                                                      child: Text('Annuler'))
                                                ],
                                              ));
                                    },
                                    child: Icon(Icons.edit,
                                        size: 25, color: Colors.orange)),
                                TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: Text(
                                                    'Voulez-vous vraiment supprimer ${allFoods[index].foodName} ?'),
                                                actions: [
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      deleteFood(
                                                          allFoods[index].id);
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    },
                                                    child: Text('Oui'),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.green,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'Annuler');
                                                    },
                                                    child: Text('Non'),
                                                  ),
                                                ]);
                                          });
                                    },
                                    child: Icon(Icons.delete,
                                        size: 25, color: Colors.red)),
                              ],
                            )
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
