import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eco_synergy/common/drawer/stylish_drawer.dart';

class Bag {
  final String name;
  final String imageUrl;

  Bag({required this.name, required this.imageUrl});
}

class BagScreen extends StatefulWidget {
  @override
  _BagScreenState createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  final TextEditingController _keywordController = TextEditingController();
  List<Bag> _filteredBags = [];

  Future<void> _fetchBags(String keyword) async {
    final response = await http.get(
      Uri.parse(
          'https://world.openfoodfacts.org/cgi/search.pl?search_terms=$keyword&json=1'),
    );

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      if (decodedData['products'] != null) {
        setState(() {
          _filteredBags = List<Bag>.from(decodedData['products'].map((product) {
            return Bag(
              name: product['product_name'] ?? 'Unknown Bag',
              imageUrl:
                  product['image_url'] ?? 'https://via.placeholder.com/150',
            );
          }));
        });
      }
    } else {
      throw Exception('Failed to fetch bag data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eco-Friendly Bags'),
      ),
      drawer: buildstylishDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _keywordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Keyword',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _fetchBags(_keywordController.text),
              child: Text('Search'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: _filteredBags.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          _filteredBags[index].imageUrl,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8),
                        Text(_filteredBags[index].name),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }
}
