import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/food.dart';
import '../repository/food_repo.dart';

class FoodAdd extends StatefulWidget {
  const FoodAdd({super.key});

  @override
  State<FoodAdd> createState() => _FoodAddState();
}

class _FoodAddState extends State<FoodAdd> {
  String validation = '';

  @override
  Widget build(BuildContext context) {
    final ctrfoofName = TextEditingController();
    final ctrImageUrl = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 2),
          Container(
            child: Image.network(
                'https://s1.1zoom.me/big0/128/Knife_Hamburger_French_fries_Fast_food_Plate_Fork_575496_1280x853.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: ctrfoofName,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        label: Text('Food name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: ctrImageUrl,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        label: Text('Image URL'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('$validation',
                          style: TextStyle(color: Colors.red)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // background
                        // foreground
                      ),
                      onPressed: () {
                        if (ctrfoofName.text.isNotEmpty &&
                            ctrImageUrl.text.isNotEmpty) {
                          final food = Food(
                              foodName: ctrfoofName.text,
                              imageUrl: ctrImageUrl.text);
                          addFood(food);
                          ctrfoofName.text = '';
                          ctrImageUrl.text = '';
                          setState(() {
                            validation = "";
                          });
                        } else {
                          setState(() {
                            validation = "Fields can't be empty";
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Add food', style: TextStyle(fontSize: 18)),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.add, size: 26),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
