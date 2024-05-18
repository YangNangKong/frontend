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

  TablingList({
    required this.id,
    required this.shopId,
    required this.tablingType,
    required this.phoneNumber,
    required this.personnel,
    required this.updatedAt,
    required this.createdAt,
    required this.deletedAt,
  });

  factory TablingList.fromJson(Map<String, dynamic> json) =>
      _$TablingListFromJson(json);

  Map<String, dynamic> toJson() => _$TablingListToJson(this);
}
