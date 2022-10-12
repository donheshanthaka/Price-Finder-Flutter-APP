import 'package:flutter_test/flutter_test.dart';
import 'package:price_finder/features/search_image/models/vehicle_model_update.dart';

void main() {
  Vehicle vehicle =  Vehicle();
  setUp(() {
    Map<String, dynamic> vehicleInfo = <String, dynamic>{};
    vehicleInfo['model'] = 'Toyota Aqua 2014';
    vehicleInfo['price'] = 'Rs: 6,500,000';
    vehicle.updateInfo(vehicleInfo);
  });

  test("Get vehicle model from getModel method", () {
    expect(vehicle.getModel(), 'Toyota Aqua 2014');
  });

  test("Get vehicle price from getPrice method", () {
    expect(vehicle.getPrice(), 'Rs: 6,500,000');
  });

}