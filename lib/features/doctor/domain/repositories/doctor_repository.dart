import 'package:flutter_application_1/features/doctor/domain/entities/doctor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class DoctorRepository {
  final SupabaseClient client;

  DoctorRepository(this.client);

  Future<List<Doctor>> fetchDoctors() async {
    final response = await client.from('doctors').select();
    return response.map<Doctor>((json) => Doctor.fromJson(json)).toList();
  }
}

