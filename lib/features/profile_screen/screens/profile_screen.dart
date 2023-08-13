import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_synergy/common/drawer/stylish_drawer.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String coins = "";

  @override
  void initState() {

    super.initState();
    getData();
  }

  getData() async {
    var firestoreData = firestore
        .collection('users')
        .doc(firebaseAuth.currentUser?.uid ?? '')
        .get()
        .then((DocumentSnapshot snapshot) {
      coins = snapshot.get('ecoCurrency');
      setState(() {});
    });
  }

  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildstylishDrawer(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.pexels.com/photos/669996/pexels-photo-669996.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                        fit: BoxFit.cover)),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    alignment: const Alignment(0.0, 2.5),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://d112y698adiu2z.cloudfront.net/photos/production/challenge_thumbnails/002/022/473/datas/original.png"),
                      radius: 60.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Armaan",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.blueGrey,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Column(children: [
                  const Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      elevation: 2.0,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
                          child: Text("Name : John Doe",
                              style: TextStyle(fontSize: 18)))),
                  const Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      elevation: 2.0,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
                          child: Text("Email : armaan33000@gmail.com",
                              style: TextStyle(fontSize: 16)))),
                  Card(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      elevation: 2.0,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
                          child: Text("Eco Coins : $coins",
                              style: const TextStyle(fontSize: 18))))
                ]),
                crossFadeState: _showDetails
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _toggleDetails,
          child: Icon(_showDetails ? Icons.expand_less : Icons.expand_more)),
    );
  }

  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }
}
