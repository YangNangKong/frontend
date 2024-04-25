import 'package:flutter/cupertino.dart';
import 'package:flutter_application/entity/tabling_list_entity.dart';

class TablingListViewModel extends ChangeNotifier {
  List<TablingListEntity> _tablingList = [
    TablingListEntity(
      id: 1,
      shopId: 1,
      tablingType: '테이블',
      phoneNumber: '010-1234-5678',
      personnel: 3,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: DateTime.now(),
    ),
    TablingListEntity(
      id: 2,
      shopId: 1,
      tablingType: '카운터',
      phoneNumber: '010-9876-5432',
      personnel: 2,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: DateTime.now(),
    ),
  ];

  List<TablingListEntity> get tablingList => _tablingList;
}
