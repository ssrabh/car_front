class Booking {
  final String name;
  final String email;
  final String phone;
  final String vehicleType;
  final List<String> services;
  final String preferredDate;
  final String preferredTime;
  final String? message;

  Booking({
    required this.name,
    required this.email,
    required this.phone,
    required this.vehicleType,
    required this.services,
    required this.preferredDate,
    required this.preferredTime,
    this.message,
  });

  // Converts the model to a JSON map for the API
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "vehicleType": vehicleType,
      "services": services,
      "preferredDate": preferredDate,
      "preferredTime": preferredTime,
      "message": message,
    };
  }
}
