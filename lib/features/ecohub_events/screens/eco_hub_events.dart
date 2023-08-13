import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:eco_synergy/constants/constants.dart';

class EcoEvents extends StatefulWidget {
  final String title;
  const EcoEvents({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _EcoEventsState createState() => _EcoEventsState();
}

class _EcoEventsState extends State<EcoEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EcoHub Events'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('events').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          return Hero(
                            tag: document.id,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewEventScreen(document)),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(document['event'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                      SizedBox(height: 8),
                                      Text(document['location']),
                                      SizedBox(height: 8),
                                      Text(document['date']),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEventScreen()),
          );
        },
        tooltip: 'Add Event',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ViewEventScreen extends StatelessWidget {
  final DocumentSnapshot document;
  ViewEventScreen(this.document);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(document['event']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Hero(
              tag: document.id,
              child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Location:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(document['location']),
                            SizedBox(height: 8),
                            Text('Date:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(document['date']),
                            SizedBox(height: 8),
                            Text('Time:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(document['time']),
                            SizedBox(height: 8),
                            Text('Description:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(document['description']),
                            SizedBox(height: 8),
                            Text('Organizer:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(document['organizer']),
                            SizedBox(height: 8),
                            Text('Contact Number:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(document['contact']),
                            SizedBox(height: 8),
                            Text('Email:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(document['email']),
                            SizedBox(height: 8),
                            Text('Website:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(document['website']),
                          ])))),
        ),
      ),
    );
  }
}

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _organizerController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _eventController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Event Name'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Location'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Date'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Time'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Description'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _organizerController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Organizer'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _contactController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Contact Number'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _websiteController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Website'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Category'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            firestore.collection('events').add({
              'event': _eventController.text,
              'location': _locationController.text,
              'date': _dateController.text,
              'time': _timeController.text,
              'description': _descriptionController.text,
              'organizer': _organizerController.text,
              'contact': _contactController.text,
              'email': _emailController.text,
              'website': _websiteController.text,
              'category': _categoryController.text
            });
            _eventController.clear();
            _locationController.clear();
            _dateController.clear();
            _timeController.clear();
            _descriptionController.clear();
            _organizerController.clear();
            _contactController.clear();
            _emailController.clear();
            _websiteController.clear();
            _categoryController.clear();
          },
          label: Text('Add Event'),
          icon: Icon(Icons.add)),
    );
  }
}
