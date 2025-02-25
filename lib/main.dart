import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Doctor List App', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Map<String, dynamic>>> fetchDoctors() async {
    const String url = 'http://localhost:8002/rest/v1/doctors';
    const String apiKey =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImppbmdndWRuY3hhbmJnbnF4eGdwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0MzE2MDQsImV4cCI6MjA1NTAwNzYwNH0.EEPWc3wChpdRvUSSqjZ1qB9SiDxbdg-pchxVvYdUySw';
    const String bearerToken =
        'eyJhbGciOiJIUzI1NiIsImtpZCI6IjU1NDlsSWtxRWxaZTZya1EiLCJ0eXAiOiJKV1QifQ.eyJhYWwiOiJhYWwxIiwiYW1yIjpbeyJtZXRob2QiOiJwYXNzd29yZCIsInRpbWVzdGFtcCI6MTc0MDQ0NTExN31dLCJhcHBfbWV0YWRhdGEiOnsicHJvdmlkZXIiOiJlbWFpbCIsInByb3ZpZGVycyI6WyJlbWFpbCJdfSwiYXVkIjoiYXV0aGVudGljYXRlZCIsImVtYWlsIjoiYnVkaUBleGFtcGxlLmNvbSIsImV4cCI6MTc0MDQ0ODcxNywiaWF0IjoxNzQwNDQ1MTE3LCJpc19hbm9ueW1vdXMiOmZhbHNlLCJpc3MiOiJodHRwczovL2ppbmdndWRuY3hhbmJnbnF4eGdwLnN1cGFiYXNlLmNvL2F1dGgvdjEiLCJwaG9uZSI6IiIsInJvbGUiOiJhdXRoZW50aWNhdGVkIiwic2Vzc2lvbl9pZCI6ImFhNDZmZjUzLWQ1NzUtNDg2Ni1hNTBmLWE1ZDA3NjRlZDM3MSIsInN1YiI6Ijc5MTgyYTFlLTJlNGItNDY1ZC1iNzQwLTc1OTU0OTgzYjdkNCIsInVzZXJfbWV0YWRhdGEiOnsiZW1haWxfdmVyaWZpZWQiOnRydWV9LCJ1c2VyX3JvbGUiOiJ1c2VyIn0.acfWqldH-tqzipXWTFot_6SOX7twH4IzNU-_V16js6E';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'apikey': apiKey,
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctors')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchDoctors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No doctors found.'));
          }

          final doctors = snapshot.data!;
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              doctor['image_url'] ??
                                  'https://static.vecteezy.com/system/resources/thumbnails/027/298/490/small/doctor-posing-portrait-free-photo.jpg',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor['name']?.toString() ?? 'Unnamed Doctor',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                doctor['specialization']?.toString() ??
                                    'Unknown Specialization',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Book Appointment'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Call Us',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
