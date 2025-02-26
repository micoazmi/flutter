import 'package:flutter_application_1/features/doctor/domain/entities/doctor.dart';
import 'package:flutter_application_1/features/doctor/domain/repositories/doctor_repository.dart';


class FetchDoctorsUseCase {
  final DoctorRepository repository;

  FetchDoctorsUseCase(this.repository);

  Future<List<Doctor>> call() async {
    return await repository.fetchDoctors();
  }
}
