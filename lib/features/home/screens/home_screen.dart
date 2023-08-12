import 'package:eco_synergy/common/drawer/stylish_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class EnergySavingInstance {
  final String process;
  final String time;
  final String energySaved;

  EnergySavingInstance({
    required this.process,
    required this.time,
    required this.energySaved,
  });
}

class _HomeScreenState extends State<HomeScreen> {
  final List<EnergySavingInstance> savedEnergyInstances = [
    EnergySavingInstance(
      process: 'Turned off the fan when not needed',
      time: '12:30 PM',
      energySaved: '30 watts',
    ),
    EnergySavingInstance(
      process: 'Used a bicycle for commuting',
      time: '08:15 AM',
      energySaved: '50 calories',
    ),
    EnergySavingInstance(
      process: 'Used a bicycle for commuting',
      time: '08:15 AM',
      energySaved: '50 calories',
    ),
    // Add more instances here
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: makeAppBar(context),
      ),
      drawer: buildstylishDrawer(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Good morning, Armaan! 👋🏻",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "12th August, 2023",
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      size: 48,
                      color: Colors.green,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Eco Coins',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '200 🪙', // Display the actual currency amount here
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Your Last Saving Instances ⚡",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: savedEnergyInstances.length,
              itemBuilder: (context, index) {
                final instance = savedEnergyInstances[index];
                return Padding(
                  padding:
                      const EdgeInsets.all(8.0).copyWith(left: 10, right: 10),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      tileColor: Colors.grey.shade100,
                      leading: Icon(Icons.lightbulb, color: Colors.yellow),
                      title: Text(
                        instance.process,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text('Time: ${instance.time}'),
                          SizedBox(height: 2),
                          Text('Energy Saved: ${instance.energySaved}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
