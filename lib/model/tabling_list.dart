import 'package:json_annotation/json_annotation.dart';

part 'tabling_list.g.dart';

@JsonSerializable()
class TablingList {
  final int id;
  final int shopId;
  final String tablingType;
  final String phoneNumber;
  final int personnel;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;

  TablingList(
     this.id,
     this.shopId,
     this.tablingType,
     this.phoneNumber,
     this.personnel,
     this.updatedAt,
     this.createdAt,
     this.deletedAt,
  );

  factory TablingList.fromJson(Map<String, dynamic> json) => _$TablingListFromJson(json);
  Map<String, dynamic> toJson() => _$TablingListToJson(this);
}