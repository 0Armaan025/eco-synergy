import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:eco_synergy/common/drawer/stylish_drawer.dart';

class RecipeScreen extends StatefulWidget {
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _ingredients = [];
  List<Map<String, dynamic>> _recipes = [];
  bool _isVeg = false;

  void _addIngredient() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _ingredients.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _searchRecipes() async {
    // Replace with your own API key and endpoint
    final String apiKey = '8063cdcba8ca4047a57db98abb4844e2';
    final String endpoint =
        'https://api.spoonacular.com/recipes/findByIngredients';

    // Build the query parameters
    final String ingredients = _ingredients.join(',');
    final int number = 10; // Number of results to return
    final Map<String, String> queryParams = {
      'apiKey': apiKey,
      'ingredients': ingredients,
      'number': number.toString(),
      'diet': _isVeg ? 'vegetarian' : '',
    };
    final Uri uri = Uri.parse(endpoint).replace(queryParameters: queryParams);

    // Send the request
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // Parse the response
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _recipes = data.map((recipe) {
          return {
            'title': recipe['title'],
            'image': recipe['image'],
            'usedIngredients': recipe['usedIngredients']
                .map((ingredient) => ingredient['name'])
                .toList(),
            'missedIngredients': recipe['missedIngredients']
                .map((ingredient) => ingredient['name'])
                .toList(),
          };
        }).toList();
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Finder'),
      ),
      drawer: buildstylishDrawer(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter an ingredient',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addIngredient,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Vegetarian'),
              Switch(
                value: _isVeg,
                onChanged: (value) {
                  setState(() {
                    _isVeg = value;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _ingredients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_ingredients[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _ingredients.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _searchRecipes,
            child: Text('Search for recipes'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(_recipes[index]['image'], width: 50.0),
                  title: InkWell(
                    onTap: () async {
                      final String query =
                          Uri.encodeComponent(_recipes[index]['title']);
                      final String url =
                          'https://www.google.com/search?q=$query';
                    },
                    child: Text(_recipes[index]['title'],
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline)),
                  ),
                  subtitle: Text(
                      'Ingredients used in this recipe are ${_recipes[index]['usedIngredients'].join(', ')}. Ingredients missed in this recipe are ${_recipes[index]['missedIngredients'].join(', ')}.'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
