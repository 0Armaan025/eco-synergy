import 'package:flutter/material.dart';

class EcoVoyagerScreen extends StatefulWidget {
  @override
  _EcoVoyagerScreenState createState() => _EcoVoyagerScreenState();
}

class _EcoVoyagerScreenState extends State<EcoVoyagerScreen> {
  List<Map<String, dynamic>> flights = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco-Voyager'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EcoExperienceCard(
              title: "World's first re-usable fuel plane",
              description:
                  'Explore the skies with an unforgettable flight experience.\nDiscover scenic landscapes and create lasting memories.',
              imageUrl:
                  'https://plus.unsplash.com/premium_photo-1674343000769-204bb2026a8c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YWlycGxhbmV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlightsScreen(
                      flights: flights,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddFlightDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddFlightDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String flightNumber = '';
        String departure = '';
        String arrival = '';
        String departureTime = '';
        String arrivalTime = '';

        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text('Add Flight'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Flight Number'),
                  onChanged: (value) => flightNumber = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Departure'),
                  onChanged: (value) => departure = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Arrival'),
                  onChanged: (value) => arrival = value,
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Departure Time'),
                  onChanged: (value) => departureTime = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Arrival Time'),
                  onChanged: (value) => arrivalTime = value,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (flightNumber.isNotEmpty &&
                      departure.isNotEmpty &&
                      arrival.isNotEmpty &&
                      departureTime.isNotEmpty &&
                      arrivalTime.isNotEmpty) {
                    flights.add({
                      'flightNumber': flightNumber,
                      'departure': departure,
                      'arrival': arrival,
                      'departureTime': departureTime,
                      'arrivalTime': arrivalTime,
                    });
                    Navigator.pop(context);
                    setState(() {});
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FlightsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> flights;

  FlightsScreen({required this.flights});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Flights'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...flights.map((flight) => FlightCard(flight: flight)),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: flights.isNotEmpty
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RegistrationScreen(flight: flights.first),
                        ),
                      )
                  : null,
              child: const Text('Register for Selected Flight'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatelessWidget {
  final Map<String, dynamic> flight;

  RegistrationScreen({required this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlightCard(flight: flight),
            const SizedBox(height: 16.0),
            const TextField(
                decoration: InputDecoration(labelText: 'Full Name')),
            const SizedBox(height: 8.0),
            const TextField(decoration: InputDecoration(labelText: 'Email')),
            const SizedBox(height: 8.0),
            const TextField(
                decoration: InputDecoration(labelText: 'Phone Number')),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement registration functionality here
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Registration Successful'),
                    content:
                        const Text('Thank you for registering for a flight!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Submit Registration'),
            ),
          ],
        ),
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  final Map<String, dynamic> flight;

  FlightCard({required this.flight});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              flight['flightNumber'] ?? '',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(flight['departure'] ?? ''),
                      Text(
                        flight['departureTime'] ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.flight_takeoff),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(flight['arrival'] ?? ''),
                      Text(
                        flight['arrivalTime'] ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EcoExperienceCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const EcoExperienceCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 200.0,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(description, style: const TextStyle(fontSize: 16.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
