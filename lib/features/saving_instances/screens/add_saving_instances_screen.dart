import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavingInstanceScreen extends StatefulWidget {
  @override
  _SavingInstanceScreenState createState() => _SavingInstanceScreenState();
}

class _SavingInstanceScreenState extends State<SavingInstanceScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _instanceController = TextEditingController();
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _energyController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Create an animation
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _addInstanceToFirestore() async {
    final instance = {
      'instance': _instanceController.text,
      'activity': _activityController.text,
      'time': _timeController.text,
      'energySaved': _energyController.text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance
          .collection('savingInstances')
          .add(instance);
      // Clear text fields
      _instanceController.clear();
      _activityController.clear();
      _timeController.clear();
      _energyController.clear();
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Instance added successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      print('Error adding instance: $error');
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding instance. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
              ScaleTransition(
                scale: _animation,
                child: TextField(
                  controller: _instanceController,
                  decoration: InputDecoration(
                    labelText: 'Instance',
                    hintText: 'e.g. Turned off fan when not needed',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  onTap: () {
                    // Play the animation
                    _animationController.forward();
                  },
                  onEditingComplete: () {
                    // Reset the animation
                    _animationController.reset();
                  },
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _activityController,
                decoration: InputDecoration(
                  labelText: 'Activity',
                  hintText: 'e.g. Used Bicycle to travel n number of km',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Time',
                  hintText: 'e.g. 12:30 am',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _energyController,
                decoration: InputDecoration(
                  labelText: 'Energy Saved',
                  hintText: 'e.g. 10 kWh',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addInstanceToFirestore,
                child: Text('Add Instance'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
