// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AcceptModelAdapter extends TypeAdapter<AcceptModel> {
  @override
  final int typeId = 3;

  @override
  AcceptModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AcceptModel(
      category: fields[0] as String,
      title: fields[1] as String,
      imagePath: (fields[2] as List).cast<String>(),
      url: fields[3] as String,
      ingredients: fields[4] as String,
      steps: fields[5] as String,
      tips: fields[6] as String,
      uploadedBy: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AcceptModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.ingredients)
      ..writeByte(5)
      ..write(obj.steps)
      ..writeByte(6)
      ..write(obj.tips)
      ..writeByte(7)
      ..write(obj.uploadedBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcceptModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
