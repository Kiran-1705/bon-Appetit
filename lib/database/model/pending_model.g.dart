// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendingModelAdapter extends TypeAdapter<PendingModel> {
  @override
  final int typeId = 4;

  @override
  PendingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingModel(
      category: fields[0] as String,
      title: fields[1] as String,
      imagePath: (fields[2] as List).cast<String>(),
      url: fields[3] as String,
      ingredients: fields[4] as String,
      steps: fields[5] as String,
      tips: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PendingModel obj) {
    writer
      ..writeByte(7)
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
      ..write(obj.tips);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
