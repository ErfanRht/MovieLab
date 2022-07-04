// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_preview.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveShowPreviewAdapter extends TypeAdapter<HiveShowPreview> {
  @override
  final int typeId = 1;

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
      ..weekend = fields[7] as String
      ..gross = fields[8] as String
      ..weeks = fields[9] as String
      ..worldwideLifetimeGross = fields[10] as String
      ..domesticLifetimeGross = fields[11] as String
      ..domestic = fields[12] as String
      ..foreignLifetimeGross = fields[13] as String
      ..foreign = fields[14] as String;
  }

  @override
  void write(BinaryWriter writer, HiveShowPreview obj) {
    writer
      ..writeByte(15)
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
      ..write(obj.weekend)
      ..writeByte(8)
      ..write(obj.gross)
      ..writeByte(9)
      ..write(obj.weeks)
      ..writeByte(10)
      ..write(obj.worldwideLifetimeGross)
      ..writeByte(11)
      ..write(obj.domesticLifetimeGross)
      ..writeByte(12)
      ..write(obj.domestic)
      ..writeByte(13)
      ..write(obj.foreignLifetimeGross)
      ..writeByte(14)
      ..write(obj.foreign);
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
