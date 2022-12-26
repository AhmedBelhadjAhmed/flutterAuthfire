import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rolebased/register.dart';
import 'package:rolebased/repository/food_repo.dart';

import 'package:rolebased/screens/client_list.dart';
import 'package:rolebased/screens/fav_list.dart';
import 'package:rolebased/screens/food_add.dart';

import 'login.dart';
import 'model/food.dart';

class Client extends StatefulWidget {
  const Client({super.key});

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  final ctrUpdateNameFood = TextEditingController();
  final ctrUpdateImageUrl = TextEditingController();

  List<Food> allFoods = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
            child: Column(
          children: [
            Container(
              height: 165,
              color: Colors.orange,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 110),
                child: Text(
                  'My food List',
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.home),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: const Text('Home'),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.favorite),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoriteList()),
                    );
                  },
                  child: const Text('Favorite List'),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.logout_sharp),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    logout(context);
                  },
                  child: const Text('Log out'),
                ),
              ],
            ),
          ],
        )),
        appBar: AppBar(
          backgroundColor: Colors.black,
          //automaticallyImplyLeading: false,
          title: const Text(
            "Client",
            style: TextStyle(color: Color.fromARGB(255, 254, 175, 91)),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.orange,
            tabs: [
              Tab(
                  icon: Icon(
                    Icons.supervised_user_circle_sharp,
                    size: 28,
                  ),
                  text: "Food List"),
              Tab(
                icon: Icon(Icons.favorite, size: 28, color: Colors.red),
                text: "Favorite list",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ClientList(),
            FavoriteList(),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
