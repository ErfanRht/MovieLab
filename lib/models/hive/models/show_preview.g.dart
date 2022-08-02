// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_preview.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveShowPreviewAdapter extends TypeAdapter<HiveShowPreview> {
  @override
  final int typeId = 0;

  @override
  HiveShowPreview read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveShowPreview()
      ..id = fields[0] as String
      ..rank = fields[1] as String
      ..title = fields[2] as String
      ..crew = fields[3] as String
      ..image = fields[4] as String
      ..year = fields[5] as String
      ..imDbRating = fields[6] as String
      ..genres = fields[7] as String?
      ..watchDate = fields[8] as DateTime?
      ..watchTime = fields[9] as TimeOfDay?;
  }

  @override
  void write(BinaryWriter writer, HiveShowPreview obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.rank)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.crew)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.year)
      ..writeByte(6)
      ..write(obj.imDbRating)
      ..writeByte(7)
      ..write(obj.genres)
      ..writeByte(8)
      ..write(obj.watchDate)
      ..writeByte(9)
      ..write(obj.watchTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveShowPreviewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
