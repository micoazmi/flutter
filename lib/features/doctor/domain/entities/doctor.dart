class Doctor {
  final int id;
  final String name;
  final String specialization;
  final String imageUrl;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.imageUrl,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as int,
      name: json['name'] ?? 'Unnamed Doctor',
      specialization: json['specialization'] ?? 'Unknown Specialization',
      imageUrl: json['image_url'] ??
          'https://static.vecteezy.com/system/resources/thumbnails/027/298/490/small/doctor-posing-portrait-free-photo.jpg',
    );
  }
}
