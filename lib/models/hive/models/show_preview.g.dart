// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_preview.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShowPreviewAdapter extends TypeAdapter<HiveShowPreview> {
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
      ..type = fields[3] as String
      ..crew = fields[4] as String
      ..image = fields[5] as String
      ..year = fields[6] as String
      ..imDbRating = fields[7] as String
      ..genres = fields[8] as String
      ..countries = fields[9] as String
      ..languages = fields[10] as String
      ..companies = fields[11] as String
      ..contentRating = fields[12] as String
      ..similars = (fields[13] as List).cast<HiveShowPreview>()
      ..watchDate = fields[14] as DateTime?
      ..watchTime = fields[15] as TimeOfDay?;
  }

  @override
  void write(BinaryWriter writer, HiveShowPreview obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.rank)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.crew)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.year)
      ..writeByte(7)
      ..write(obj.imDbRating)
      ..writeByte(8)
      ..write(obj.genres)
      ..writeByte(9)
      ..write(obj.countries)
      ..writeByte(10)
      ..write(obj.languages)
      ..writeByte(11)
      ..write(obj.companies)
      ..writeByte(12)
      ..write(obj.contentRating)
      ..writeByte(13)
      ..write(obj.similars)
      ..writeByte(14)
      ..write(obj.watchDate)
      ..writeByte(15)
      ..write(obj.watchTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShowPreviewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
