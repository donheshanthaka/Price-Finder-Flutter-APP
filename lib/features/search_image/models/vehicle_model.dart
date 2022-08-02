// Represents a vehicle that includes its model and current market price
class Vehicle {
  final String model;
  final String price;

  Vehicle({required this.model, required this.price});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      model: json['model'] ?? "",
      price: json['price'] ?? "",
    );
  }
}
