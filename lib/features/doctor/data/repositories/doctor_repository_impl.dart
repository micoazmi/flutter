import 'package:supabase/src/supabase_client.dart';

import '../../domain/entities/doctor.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../datasources/doctor_remote_data_source.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Doctor>> fetchDoctors() async {
    return await remoteDataSource.fetchDoctors();
  }

  @override
  // TODO: implement client
  SupabaseClient get client => throw UnimplementedError();
}
