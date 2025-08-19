class UserEntity {
  final int id;
  final String email;
  final String username;
  final NameEntity name;
  final AddressEntity address;
  final String phone;

  const UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.address,
    required this.phone,
  });
}

class NameEntity {
  final String firstname;
  final String lastname;

  const NameEntity({
    required this.firstname,
    required this.lastname,
  });

  String get fullName => '$firstname $lastname';
}

class AddressEntity {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeoLocationEntity geolocation;

  const AddressEntity({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  String get fullAddress => '$number $street, $city $zipcode';
}

class GeoLocationEntity {
  final String lat;
  final String long;

  const GeoLocationEntity({
    required this.lat,
    required this.long,
  });
}
