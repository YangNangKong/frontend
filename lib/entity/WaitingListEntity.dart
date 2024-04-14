class WaitingListEntity {
  int id;
  int shopId;
  String tablingType;
  String phoneNumber;
  int personnel;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  WaitingListEntity({
    required this.id,
    required this.shopId,
    required this.tablingType,
    required this.phoneNumber,
    required this.personnel,
    required this.updatedAt,
    required this.createdAt,
    required this.deletedAt,
  });
}
