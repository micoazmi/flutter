import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/doctor/domain/entities/doctor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/doctor_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text(
          'Doctor List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: BlocBuilder<DoctorBloc, DoctorState>(
        builder: (context, state) {
          if (state is DoctorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DoctorError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is DoctorLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.doctors.length,
              itemBuilder: (context, index) {
                return DoctorCard(doctor: state.doctors[index]);
              },
            );
          }
          return const Center(child: Text('No doctors found.'));
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 30, backgroundImage: NetworkImage(doctor.imageUrl)),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(doctor.specialization, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                TextButton(onPressed: () {}, child: const Text('Call now', style: TextStyle(color: Colors.blue, fontSize: 14))),
                TextButton(onPressed: () {}, child: const Text('Book Appointment', style: TextStyle(color: Colors.blue, fontSize: 14))),
                const Spacer(),
                CircleAvatar(radius: 18, backgroundColor: Colors.teal, child: const Icon(Icons.send, color: Colors.white, size: 20)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
