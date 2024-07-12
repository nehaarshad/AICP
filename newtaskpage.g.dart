// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newtaskpage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class newtaskpageAdapter extends TypeAdapter<newtaskpage> {
  @override
  final int typeId = 0;

  @override
  newtaskpage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return newtaskpage(
      title: fields[0] as dynamic,
      des: fields[1] as dynamic,
      priority: fields[2] as dynamic,
      dateandtime: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, newtaskpage obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.des)
      ..writeByte(2)
      ..write(obj.priority)
      ..writeByte(3)
      ..write(obj.dateandtime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is newtaskpageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
