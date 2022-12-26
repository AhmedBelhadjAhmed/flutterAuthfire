class Food {
  String id;
  String foodName;
  String imageUrl;

  Food({this.id = '', required this.foodName, required this.imageUrl});

//convertion
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodName': foodName,
      'imageUrl': imageUrl,
    };
  }

  //construire un objet a partir d'une collection

  factory Food.fromJson(Map<String, dynamic> Json) {
    return Food(
        id: Json['id'], foodName: Json['foodName'], imageUrl: Json['imageUrl']);
  }
}
