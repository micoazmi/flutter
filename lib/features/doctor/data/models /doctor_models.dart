import '../../domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    required int id,
    required String name,
    required String specialization,
    required String imageUrl,
  }) : super(
         id: id,
         name: name,
         specialization: specialization,
         imageUrl: imageUrl,
       );

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as int,
      name: json['name'] ?? 'Unnamed Doctor',
      specialization: json['specialization'] ?? 'Unknown Specialization',
      imageUrl:
          json['image_url'] ??
          'https://static.vecteezy.com/system/resources/thumbnails/027/298/490/small/doctor-posing-portrait-free-photo.jpg',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'image_url': imageUrl,
    };
  }
}
