import 'package:flutter/material.dart';
import 'package:eco_synergy/common/drawer/stylish_drawer.dart';

class CarbonFootprintScreen extends StatefulWidget {
  @override
  _CarbonFootprintScreenState createState() => _CarbonFootprintScreenState();
}

class _CarbonFootprintScreenState extends State<CarbonFootprintScreen> {
  final _formKey = GlobalKey<FormState>();
  double _carbonFootprint = 0.0;
  double _electricity = 0.0;
  double _gas = 0.0;
  double _water = 0.0;

  void _calculateCarbonFootprint() {
    setState(() {
      _carbonFootprint =
          (_electricity * 1.37) + (_gas * 6.61) + (_water * 0.708);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carbon Footprint Calculator'),
        backgroundColor: Colors.green,
      ),
      drawer: buildstylishDrawer(context),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Electricity (kWh)',
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _electricity = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Gas (therms)',
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _gas = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Water (gallons)',
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _water = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _calculateCarbonFootprint,
                child: Text('Calculate', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green, elevation: 5),
              ),
              SizedBox(height: 16.0),
              Text('Your carbon footprint is $_carbonFootprint lbs CO2e',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
