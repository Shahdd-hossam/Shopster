// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritesHiveModelAdapter extends TypeAdapter<FavoritesHiveModel> {
  @override
  final int typeId = 1;

  @override
  FavoritesHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoritesHiveModel(
      products: (fields[0] as List).cast<ProductHiveModel>(),
      lastUpdated: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoritesHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.products)
      ..writeByte(1)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductHiveModelAdapter extends TypeAdapter<ProductHiveModel> {
  @override
  final int typeId = 11;

  @override
  ProductHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductHiveModel(
      id: fields[0] as int,
      title: fields[1] as String,
      price: fields[2] as double,
      description: fields[3] as String,
      category: fields[4] as String,
      image: fields[5] as String,
      rating: fields[6] as RatingHiveModel?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RatingHiveModelAdapter extends TypeAdapter<RatingHiveModel> {
  @override
  final int typeId = 12;

  @override
  RatingHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RatingHiveModel(
      rate: fields[0] as double,
      count: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RatingHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.rate)
      ..writeByte(1)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatingHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
