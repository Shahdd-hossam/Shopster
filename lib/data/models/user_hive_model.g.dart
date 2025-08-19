// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveModelAdapter extends TypeAdapter<UserHiveModel> {
  @override
  final int typeId = 2;

  @override
  UserHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHiveModel(
      id: fields[0] as int,
      email: fields[1] as String,
      username: fields[2] as String,
      name: fields[3] as NameHiveModel,
      address: fields[4] as AddressHiveModel,
      phone: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NameHiveModelAdapter extends TypeAdapter<NameHiveModel> {
  @override
  final int typeId = 3;

  @override
  NameHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NameHiveModel(
      firstname: fields[0] as String,
      lastname: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NameHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.firstname)
      ..writeByte(1)
      ..write(obj.lastname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NameHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressHiveModelAdapter extends TypeAdapter<AddressHiveModel> {
  @override
  final int typeId = 4;

  @override
  AddressHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressHiveModel(
      city: fields[0] as String,
      street: fields[1] as String,
      number: fields[2] as int,
      zipcode: fields[3] as String,
      geolocation: fields[4] as GeoLocationHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, AddressHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.street)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.zipcode)
      ..writeByte(4)
      ..write(obj.geolocation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GeoLocationHiveModelAdapter extends TypeAdapter<GeoLocationHiveModel> {
  @override
  final int typeId = 5;

  @override
  GeoLocationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeoLocationHiveModel(
      lat: fields[0] as String,
      long: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GeoLocationHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeoLocationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
