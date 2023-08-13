import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:eco_synergy/common/drawer/stylish_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeScreen extends StatefulWidget {
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _ingredients = [];
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
    const String apiKey = '8063cdcba8ca4047a57db98abb4844e2';
    const String endpoint =
        'https://api.spoonacular.com/recipes/findByIngredients';

    // Build the query parameters
    final String ingredients = _ingredients.join(',');
    const int number = 10; // Number of results to return
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
      if (kDebugMode) {
        print('Error: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Finder'),
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
                  icon: const Icon(Icons.add),
                  onPressed: _addIngredient,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Vegetarian'),
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
                    icon: const Icon(Icons.delete),
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
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(_recipes[index]['image'], height: 100.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            final String query =
                                Uri.encodeComponent(_recipes[index]['title']);
                            final String url =
                                'https://www.google.com/search?q=$query';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              if (kDebugMode) {
                                print("Could not launch $url");
                              }
                            }
                          },
                          child: Text(
                            _recipes[index]['title'],
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Used Ingredients: ${_recipes[index]['usedIngredients'].join(', ')}',
                        style: TextStyle(fontSize: 8.2),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
