import 'package:flutter/material.dart';
import 'package:rolebased/model/food.dart';
import 'package:rolebased/register.dart';
import 'package:rolebased/repository/food_repo.dart';

class DishElement extends StatefulWidget {
  const DishElement({
    super.key,
    required this.food,
    required this.isFavorite,
  });

  final Food food;
  final bool isFavorite;

  @override
  State<DishElement> createState() => _DishElementState();
}

class _DishElementState extends State<DishElement> {
  bool _isFavorite = false;

  @override
  void initState() {
    setState(
      () {
        _isFavorite = widget.isFavorite;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
          ), // to add radius for the image we need ClipRRect
          child: Image.network(
            widget.food.imageUrl,
            height: 250,
            width: double.infinity, // all the width
            fit: BoxFit.cover, //cover all the container
          ),
        ),
        Container(
          color: const Color.fromARGB(255, 0, 0, 0),
          alignment: Alignment.center, //centred text
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              Text(
                widget.food.foodName,
                style: const TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 234, 83, 83),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      if (_isFavorite) {
                        deleteFavorite(widget.food.id, returnUserId());
                        setState(
                          () {
                            _isFavorite = false;
                          },
                        );
                      } else {
                        addSubCollection(
                          widget.food.id,
                          widget.food.foodName,
                          widget.food.imageUrl,
                        );
                        setState(
                          () {
                            _isFavorite = true;
                          },
                        );
                      }
                      // String idparam = food.id;
                      // String foodNameparam = food.foodName;
                      // String imageUrlparam = food.imageUrl;
                      // var favorite = FavoriteList.favpr;
                      // for (int i = 0; i < favorite.length; i++) {
                      //   if (favorite[i].id.contains(idparam)) {
                      //     exist = true;
                      //   }
                      // }

                      // if (exist == true) {
                      //   print("exist");

                      //   setState(() {
                      //     heartFavorite = true;
                      //   });
                      //   print("heartFavorite :  $heartFavorite");

                      //   print('id param: ' + idparam);
                      //   print('user id : ' + returnUserId());
                      //   print(heartFavorite);
                      // } else {
                      //   addSubCollection(idparam, foodNameparam, imageUrlparam);
                      //   setState(() {
                      //     heartFavorite = false;
                      //   });
                      //   print(heartFavorite);
                      // }
                    },
                    child: Icon(
                      Icons.favorite,
                      size: 25,
                      color: _isFavorite ? Colors.red : Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
