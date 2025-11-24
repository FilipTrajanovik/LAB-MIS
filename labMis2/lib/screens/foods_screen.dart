import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_mis_2/models/category_model.dart';
import 'package:lab_mis_2/models/food_model.dart';
import 'package:lab_mis_2/services/api_service.dart';

import '../widgets/food_card.dart';

class FoodsScreen extends StatefulWidget{
  final CategoryModel category;

  const FoodsScreen({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen>{

  final ApiService _apiService = ApiService();
  List<Food> _foods = [];
  List<Food> _filteredFoods = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _loadFoods();
  }

  void _loadFoods() async{
    try{
      final foodsList = await _apiService.loadFoodsByCategory(category: widget.category.name,);
      setState(() {
        _isLoading = false;
        _foods = foodsList;
        _filteredFoods = foodsList;
      });
    }catch(e){
      print("Error loading foods: $e");
      setState(() {
        _isLoading=true;
      });
    }
  }

  void _searchFoods(String query) async {
    if(query.isEmpty){
      setState(() {
        _filteredFoods = _foods;
      });
      return;
    }
    try{
      final searchResults = await _apiService.searchFoods(query: query);
      setState(() {
        _filteredFoods = searchResults;
      });
    }catch(e){
      print('Error searching foods: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: Colors.orange,
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchFoods,
              decoration: InputDecoration(
                hintText: 'Пребарувај јадења',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _searchFoods('');
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          Expanded(
            child: _filteredFoods.isEmpty
                ? Center(
              child: Text(
                'Нема пронајдено јадења',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
                : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: _filteredFoods.length,
              itemBuilder: (context, index) {
                final food = _filteredFoods[index];
                return FoodCard(food: food);
              },
            ),
          ),
        ],
      ),
    );
  }

}