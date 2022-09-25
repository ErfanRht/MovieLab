// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_preview.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActorPreviewAdapter extends TypeAdapter<HiveActorPreview> {
  @override
  final int typeId = 3;

  @override
  HiveActorPreview read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveActorPreview(
      id: fields[0] as String,
      name: fields[1] as String,
      image: fields[2] as String,
      asCharacter: fields[3] as String,
      knownFor: (fields[4] as List).cast<HiveShowPreview>(),
      height: fields[7] as String,
      birthDate: fields[5] as String,
      deathDate: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveActorPreview obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.asCharacter)
      ..writeByte(4)
      ..write(obj.knownFor)
      ..writeByte(5)
      ..write(obj.birthDate)
      ..writeByte(6)
      ..write(obj.deathDate)
      ..writeByte(7)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActorPreviewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
