class DriverModel {
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

  DriverModel(
      {this.driver,
      this.sessionId,
      this.distanceToDriver,
      this.distanceToDestination,
      this.cost,
      this.paymentMethod,
      this.estimatedTimeToArrive,
      this.estimatedTimeToDestination,
      this.totalEstimatedTime,
      this.locationName,
      this.destinationName});

  DriverModel.fromJson(Map<String, dynamic> json) {
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['sessionId'] = this.sessionId;
    data['distanceToDriver'] = this.distanceToDriver;
    data['distanceToDestination'] = this.distanceToDestination;
    data['cost'] = this.cost;
    data['paymentMethod'] = this.paymentMethod;
    data['estimatedTimeToArrive'] = this.estimatedTimeToArrive;
    data['estimatedTimeToDestination'] = this.estimatedTimeToDestination;
    data['totalEstimatedTime'] = this.totalEstimatedTime;
    data['locationName'] = this.locationName;
    data['destinationName'] = this.destinationName;
    return data;
  }
}

class Driver {
  Location? location;
  String? sId;
  String? fullname;
  String? age;
  String? email;
  String? color;
  String? model;
  String? carnum;
  String? cardescription;
  String? phone;
  bool? isOnline;
  String? numberOfReviews;
  String? rating;

  Driver(
      {this.location,
      this.sId,
      this.fullname,
      this.age,
      this.email,
      this.color,
      this.model,
      this.carnum,
      this.cardescription,
      this.phone,
      this.isOnline,
      this.numberOfReviews,
      this.rating});

  Driver.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    fullname = json['fullname'];
    age = json['age'];
    email = json['email'];
    color = json['color'];
    model = json['model'];
    carnum = json['carnum'];
    cardescription = json['cardescription'];
    phone = json['phone'];
    isOnline = json['isOnline'];
    numberOfReviews = json['numberOfReviews'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['fullname'] = this.fullname;
    data['age'] = this.age;
    data['email'] = this.email;
    data['color'] = this.color;
    data['model'] = this.model;
    data['carnum'] = this.carnum;
    data['cardescription'] = this.cardescription;
    data['phone'] = this.phone;
    data['isOnline'] = this.isOnline;
    data['numberOfReviews'] = this.numberOfReviews;
    data['rating'] = this.rating;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
