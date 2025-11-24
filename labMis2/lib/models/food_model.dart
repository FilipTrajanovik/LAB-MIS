class Food {
  String id;
  String img;
  String name;

  Food({required this.id, required this.img, required this.name});

  Food.fromJson(Map<String, dynamic> data):
      id = data['idMeal'],
      img = data['strMealThumb'],
      name = data['strMeal'];

  Map<String, dynamic> toJson() => {
    'idMeal' : id,
    'strMealThumb' : img,
    'strMeal' : name
  };
}