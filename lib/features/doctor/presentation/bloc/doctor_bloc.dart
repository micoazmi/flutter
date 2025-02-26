import 'package:flutter_application_1/features/doctor/domain/entities/doctor.dart';
import 'package:flutter_application_1/features/doctor/domain/usecases/fetch_doctors_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class DoctorEvent {}

class FetchDoctors extends DoctorEvent {}

// States
abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final List<Doctor> doctors;
  DoctorLoaded(this.doctors);
}

class DoctorError extends DoctorState {
  final String message;
  DoctorError(this.message);
}

// Bloc
class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final FetchDoctorsUseCase fetchDoctorsUseCase;

  DoctorBloc(this.fetchDoctorsUseCase) : super(DoctorInitial()) {
    on<FetchDoctors>((event, emit) async {
      emit(DoctorLoading());
      try {
        final doctors = await fetchDoctorsUseCase();
        emit(DoctorLoaded(doctors));
      } catch (e) {
        emit(DoctorError(e.toString()));
      }
    });
  }
}
