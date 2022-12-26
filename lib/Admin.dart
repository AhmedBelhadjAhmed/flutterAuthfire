import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rolebased/register.dart';
import 'package:rolebased/screens/all_dishes.dart';
import 'package:rolebased/screens/filterList.dart';
import 'package:rolebased/screens/food_add.dart';

import 'login.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
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
          centerTitle: true,
          backgroundColor: Colors.black,
          //automaticallyImplyLeading: false,
          title: Text("Administrateur"),
          actions: [
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(
                Icons.logout,
              ),
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.orange,
            tabs: [
              Tab(
                  icon: Icon(
                    Icons.supervised_user_circle_sharp,
                    size: 28,
                  ),
                  text: "Add"),
              Tab(
                  icon: Icon(
                    Icons.edit_attributes,
                    size: 28,
                  ),
                  text: "Food list"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FoodAdd(),
            AllDishes(),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
