class DriverModel {
  DriverModel({
      this.driver, 
      this.sessionId, 
      this.distanceToDriver, 
      this.distanceToDestination, 
      this.cost, 
      this.paymentMethod, 
      this.estimatedTimeToArrive, 
      this.estimatedTimeToDestination, 
      this.totalEstimatedTime, 
      this.locationName, 
      this.destinationName,});

  DriverModel.fromJson(dynamic json) {
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    sessionId = json['sessionId'];
    distanceToDriver = json['distanceToDriver'];
    distanceToDestination = json['distanceToDestination'];
    cost = json['cost'];
    paymentMethod = json['paymentMethod'];
    estimatedTimeToArrive = json['estimatedTimeToArrive'];
    estimatedTimeToDestination = json['estimatedTimeToDestination'];
    totalEstimatedTime = json['totalEstimatedTime'];
    locationName = json['locationName'];
    destinationName = json['destinationName'];
  }
  Driver? driver;
  String? sessionId;
  String? distanceToDriver;
  String? distanceToDestination;
  String? cost;
  String? paymentMethod;
  String? estimatedTimeToArrive;
  String? estimatedTimeToDestination;
  String? totalEstimatedTime;
  String? locationName;
  String? destinationName;
  

}

class Driver {
  Driver({
    this.location,
    this.id,
    this.fullname,
    this.age,
    this.email,
    this.color,
    this.model,
    this.carnum,
    this.cardescription,
    this.phone,
    this.isOnline,});

  Driver.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    id = json['_id'];
    fullname = json['fullname'];
    age = json['age'];
    email = json['email'];
    color = json['color'];
    model = json['model'];
    carnum = json['carnum'];
    cardescription = json['cardescription'];
    phone = json['phone'];
    isOnline = json['isOnline'];
  }
  Location? location;
  String? id;
  String? fullname;
  String? age;
  String? email;
  String? color;
  String? model;
  String? carnum;
  String? cardescription;
  String? phone;
  bool? isOnline;

}
class Location {
  Location({
    this.type,
    this.coordinates,});

  Location.fromJson(dynamic json) {
    type = json['type'];
    coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
  }
  String? type;
  List<num>? coordinates;

}