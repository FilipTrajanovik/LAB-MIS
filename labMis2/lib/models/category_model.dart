class CategoryModel{
  String id;
  String name;
  String img;
  String description;

  CategoryModel({required this.id,required this.name, required this.img, required this.description});

  CategoryModel.fromJson(Map<String, dynamic> data):
      id = data['idCategory'],
      name = data['strCategory'],
      img = data['strCategoryThumb'],
      description = data['strCategoryDescription'];

  Map<String, dynamic> toJson() => {
    'idCategory' : id,
    'strCategory' : name,
    'strCategoryThumb' : img,
    'strCategoryDescription' : description
  };
}