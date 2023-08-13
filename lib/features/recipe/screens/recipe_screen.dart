import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: RecipeScreen(),
  ));
}

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
    final String apiKey = '8063cdcba8ca4047a57db98abb4844e2'; // Your API key
    final String endpoint =
        'https://api.spoonacular.com/recipes/findByIngredients';

    final String ingredients = _ingredients.join(',');
    final int number = 10;
    final Map<String, String> queryParams = {
      'apiKey': apiKey,
      'ingredients': ingredients,
      'number': number.toString(),
      'diet': _isVeg ? 'vegetarian' : '',
    };
    final Uri uri = Uri.parse(endpoint).replace(queryParameters: queryParams);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
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
      print('Error: ${response.statusCode}');
    }
  }

  void _shareRecipe(String recipeTitle) {
    String message = "I made a delicious recipe: $recipeTitle! Check it out.";
    String twitterUrl =
        "https://twitter.com/intent/tweet?text=${Uri.encodeComponent(message)}";

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => WebviewScaffold(
    //       url: twitterUrl,
    //       appBar: AppBar(
    //         title: Text('Share on Twitter'),
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Finder'),
      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_recipes.isNotEmpty) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.share),
                        title: Text('Share Recipe'),
                      ),
                      ListTile(
                        leading: Icon(Icons.share_outlined),
                        title: Text('Share on Twitter'),
                        onTap: () {
                          _shareRecipe(
                              _recipes[0]['title']); // Share the first recipe
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
        child: Icon(Icons.share),
      ),
    );
  }
}
