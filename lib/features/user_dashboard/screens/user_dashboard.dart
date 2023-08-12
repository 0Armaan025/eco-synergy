import 'dart:async';
import 'package:eco_synergy/common/drawer/stylish_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/utils.dart';

class DashboardScreen extends StatefulWidget {
  final int totalCarbonFootprints;
  final double distanceTravelled;
  final int resourcesWasted;
  final int foodSaved;
  final int ecoCoins;

  const DashboardScreen({
    Key? key,
    required this.totalCarbonFootprints,
    required this.distanceTravelled,
    required this.resourcesWasted,
    required this.foodSaved,
    required this.ecoCoins,
  }) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Timer _timer;
  String _date = DateFormat.yMMMMd('en_US').format(DateTime.now());
  String _time = DateFormat.jm().format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        _date = DateFormat.yMMMMd('en_US').format(DateTime.now());
        _time = DateFormat.jm().format(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: makeAppBar(context),
      ),
      drawer: buildStylishDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, Armaan!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(_date, style: TextStyle(fontSize: 18)),
                    Text(_time, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              children: [
                DashboardItem(
                  title: 'Total Carbon Footprints',
                  value: '${widget.totalCarbonFootprints} 👣',
                  color: Colors.red,
                ),
                DashboardItem(
                  title: 'Distance Travelled without Vehicle',
                  value: '${widget.distanceTravelled} km 🛣️',
                  color: Colors.green,
                ),
                DashboardItem(
                  title: 'Resources Wasted',
                  value: '${widget.resourcesWasted} 💧',
                  color: Colors.orange,
                ),
                DashboardItem(
                  title: 'Food Saved',
                  value: '${widget.foodSaved} kg 🍔',
                  color: Colors.blue,
                ),
                DashboardItem(
                  title: 'Eco Coins',
                  value: '${widget.ecoCoins} coins 🪙',
                  color: Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const DashboardItem({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        margin: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: color),
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the content vertically
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70)),
                  SizedBox(height: 8),
                  Text(value,
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))
                ]),
          ),
        ),
      ),
    );
  }
}
