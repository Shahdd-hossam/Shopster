import 'package:hive/hive.dart';
import '../../domain/entities/user_entity.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: 2)
class UserHiveModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final NameHiveModel name;

  @HiveField(4)
  final AddressHiveModel address;

  @HiveField(5)
  final String phone;

  UserHiveModel({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory UserHiveModel.fromJson(Map<String, dynamic> json) {
    return UserHiveModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      name: NameHiveModel.fromJson(json['name']),
      address: AddressHiveModel.fromJson(json['address']),
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'name': name.toJson(),
      'address': address.toJson(),
      'phone': phone,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      username: username,
      name: name.toEntity(),
      address: address.toEntity(),
      phone: phone,
    );
  }

  factory UserHiveModel.fromEntity(UserEntity entity) {
    return UserHiveModel(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      name: NameHiveModel.fromEntity(entity.name),
      address: AddressHiveModel.fromEntity(entity.address),
      phone: entity.phone,
    );
  }
}

@HiveType(typeId: 3)
class NameHiveModel extends HiveObject {
  @HiveField(0)
  final String firstname;

  @HiveField(1)
  final String lastname;

  NameHiveModel({
    required this.firstname,
    required this.lastname,
  });

  factory NameHiveModel.fromJson(Map<String, dynamic> json) {
    return NameHiveModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  NameEntity toEntity() {
    return NameEntity(
      firstname: firstname,
      lastname: lastname,
    );
  }

  factory NameHiveModel.fromEntity(NameEntity entity) {
    return NameHiveModel(
      firstname: entity.firstname,
      lastname: entity.lastname,
    );
  }
}

@HiveType(typeId: 4)
class AddressHiveModel extends HiveObject {
  @HiveField(0)
  final String city;

  @HiveField(1)
  final String street;

  @HiveField(2)
  final int number;

  @HiveField(3)
  final String zipcode;

  @HiveField(4)
  final GeoLocationHiveModel geolocation;

  AddressHiveModel({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory AddressHiveModel.fromJson(Map<String, dynamic> json) {
    return AddressHiveModel(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
      geolocation: GeoLocationHiveModel.fromJson(json['geolocation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
      'geolocation': geolocation.toJson(),
    };
  }

  AddressEntity toEntity() {
    return AddressEntity(
      city: city,
      street: street,
      number: number,
      zipcode: zipcode,
      geolocation: geolocation.toEntity(),
    );
  }

  factory AddressHiveModel.fromEntity(AddressEntity entity) {
    return AddressHiveModel(
      city: entity.city,
      street: entity.street,
      number: entity.number,
      zipcode: entity.zipcode,
      geolocation: GeoLocationHiveModel.fromEntity(entity.geolocation),
    );
  }
}

@HiveType(typeId: 5)
class GeoLocationHiveModel extends HiveObject {
  @HiveField(0)
  final String lat;

  @HiveField(1)
  final String long;

  GeoLocationHiveModel({
    required this.lat,
    required this.long,
  });

  factory GeoLocationHiveModel.fromJson(Map<String, dynamic> json) {
    return GeoLocationHiveModel(
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }

  GeoLocationEntity toEntity() {
    return GeoLocationEntity(
      lat: lat,
      long: long,
    );
  }

  factory GeoLocationHiveModel.fromEntity(GeoLocationEntity entity) {
    return GeoLocationHiveModel(
      lat: entity.lat,
      long: entity.long,
    );
  }
}
