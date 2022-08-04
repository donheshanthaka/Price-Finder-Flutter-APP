class Vehicle {
  late String model;
  late String price;

  Vehicle();

  void updateInfo(Map<String, dynamic> data){
    model = data['model'];
    price = data['price'];
  }

  String getModel(){
    return model;
  }

  String getprice(){
    return price;
  }

  }


