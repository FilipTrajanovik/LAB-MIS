import 'package:flutter/cupertino.dart';
import 'package:lab_mis_2/models/category_model.dart';
import 'package:lab_mis_2/models/food_model.dart';
import 'package:lab_mis_2/screens/recipe_screen.dart';
import 'package:lab_mis_2/services/api_service.dart';

import '../widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{

  final ApiService _apiService = ApiService();
  late final List<CategoryModel> _categories;
   List<CategoryModel> _filteredCategories = [];
  bool _isLoading = true;
  bool _isSearching = false;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _loadCategories(n: 20);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.shuffle),
          onPressed: _showRandomRecipe,
        ),
      ),
      child: SafeArea(
        child: _isLoading
            ? Center(
          child: CupertinoActivityIndicator(
            radius: 20,
          ),
        )
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Пребарувај категории',
                onChanged: _filterCategories,
                onSuffixTap: () {
                  _searchController.clear();
                  _filterCategories('');
                },
              ),
            ),
            Expanded(
              child: _filteredCategories.isEmpty
                  ? Center(
                child: Text(
                  'Нема пронајдено категории',
                  style: TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              )
                  : GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemCount: _filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = _filteredCategories[index];
                  return CategoryCard(category: category);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadCategories({required int n}) async {
    try {
      final categoriesList = await _apiService.loadCategories(n: n);
      print('Categories loaded: ${categoriesList.length}');
      setState(() {
        _isLoading = false;
        _categories = categoriesList;
        _filteredCategories = categoriesList;
      });
    } catch (e) {
      print('Error loading categories: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterCategories(String name) {
    setState(() {
      if(name.isEmpty){
        _filteredCategories = _categories;
      }else{
        _filteredCategories = _categories.where((category) => category.name.toLowerCase().contains(name.toLowerCase())).toList();
      }
    });
  }

  void _showRandomRecipe() async {
    try {
      final recipe = await _apiService.getRandomRecipe();
      if (recipe != null) {
        final food = Food(
          id: recipe.id,
          name: recipe.name,
          img: recipe.img,
        );

        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => RecipeScreen(food: food),
          ),
        );
      }
    } catch (e) {
      print('Error loading random recipe: $e');
    }
  }
}
