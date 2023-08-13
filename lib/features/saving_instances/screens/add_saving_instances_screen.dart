import 'package:flutter/material.dart';

class SavingInstanceScreen extends StatefulWidget {
  @override
  _SavingInstanceScreenState createState() => _SavingInstanceScreenState();
}

class _SavingInstanceScreenState extends State<SavingInstanceScreen> {
  final TextEditingController _instanceController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _energyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Saving Instance'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 193, 217, 237),
              Color.fromARGB(255, 247, 241, 248)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _instanceController,
                decoration: InputDecoration(
                  labelText: 'Instance',
                  hintText: 'e.g. Turned off fan when not needed',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Time',
                  hintText: 'e.g. 12:30 am',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _energyController,
                decoration: InputDecoration(
                  labelText: 'Energy Saved',
                  hintText: 'e.g. 10 kWh',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // TODO:
                  // Add saving instance logic
                },
                child: Text('Add Instance'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
