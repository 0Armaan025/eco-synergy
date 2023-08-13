import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_synergy/features/saving_instances/screens/add_saving_instances_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/constants.dart';

class HomeScreen extends StatefulWidget {
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<EnergySavingInstance> savedEnergyInstances = [];

  String coins = "";

  @override
  void initState() {
    super.initState();
    _loadSavedInstances();
    getData();
  }

  getData() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        var firestoreData = _firestore
            .collection('users')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot snapshot) {
          coins = snapshot.get('ecoCurrency');
          setState(() {});
        });
      } else {
        if (kDebugMode) {
          print('User is not logged in.');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error getting user data: $error');
      }
    }
  }

  Future<void> _loadSavedInstances() async {
    try {
      final snapshot = await _firestore.collection('savingInstances').get();
      final instances = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return EnergySavingInstance(
          process: data['instance'],
          time: data['time'],
          energySaved: data['energySaved'],
        );
      }).toList();

      setState(() {
        savedEnergyInstances.addAll(instances);
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error loading instances: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: AppBar(
          title: const Text('Home Screen'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SavingInstanceScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    "Good morning, Armaan! 👋🏻",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
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
            const SizedBox(height: 30),
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_balance_wallet,
                      size: 48,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Eco Coins',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$coins 🪙', // Display the actual currency amount here
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Your Last Saving Instances ⚡",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                      leading:
                          const Icon(Icons.lightbulb, color: Colors.yellow),
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
                          const SizedBox(height: 4),
                          Text('Time: ${instance.time}'),
                          const SizedBox(height: 2),
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
