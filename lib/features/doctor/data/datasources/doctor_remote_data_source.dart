import 'package:supabase_flutter/supabase_flutter.dart';

import '../models /doctor_models.dart';

abstract class DoctorRemoteDataSource {
  Future<List<DoctorModel>> fetchDoctors();
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final SupabaseClient client;

  DoctorRemoteDataSourceImpl(this.client);

  @override
  Future<List<DoctorModel>> fetchDoctors() async {
    final response = await client.from('doctors').select();
    return response
        .map<DoctorModel>((json) => DoctorModel.fromJson(json))
        .toList();
  }
}
