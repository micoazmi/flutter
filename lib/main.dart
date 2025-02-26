import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:flutter_application_1/features/doctor/domain/usecases/fetch_doctors_usecase.dart';
import 'package:flutter_application_1/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:flutter_application_1/features/doctor/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://jinggudncxanbgnqxxgp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImppbmdndWRuY3hhbmJnbnF4eGdwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0MzE2MDQsImV4cCI6MjA1NTAwNzYwNH0.EEPWc3wChpdRvUSSqjZ1qB9SiDxbdg-pchxVvYdUySw',
  );

  final repository = DoctorRepository(Supabase.instance.client);
  final fetchDoctorsUseCase = FetchDoctorsUseCase(repository);

  runApp(MyApp(fetchDoctorsUseCase));
}

class MyApp extends StatelessWidget {
  final FetchDoctorsUseCase fetchDoctorsUseCase;

  const MyApp(this.fetchDoctorsUseCase, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DoctorBloc(fetchDoctorsUseCase)..add(FetchDoctors())),
      ],
      child: const MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
    );
  }
}
