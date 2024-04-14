import 'package:flutter/cupertino.dart';

import '../entity/WaitingListEntity.dart';

class WaitingListViewModel extends ChangeNotifier {
  List<WaitingListEntity> _waitingList = [
    WaitingListEntity(
      id: 1,
      shopId: 1,
      tablingType: '테이블',
      phoneNumber: '010-1234-5678',
      personnel: 3,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: DateTime.now(),
    ),
    WaitingListEntity(
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

  // Future<void> fetchWaitingList() async {
  //   await Future.delayed(Duration(seconds: 1));
  //
  //   _waitingList = [
  //     WaitingListEntity(
  //       id: 1,
  //       shopId: 1,
  //       tablingType: '테이블',
  //       phoneNumber: '010-1234-5678',
  //       personnel: 3,
  //       createdAt: DateTime.now(),
  //       updatedAt: DateTime.now(),
  //       deletedAt: DateTime.now(),
  //     ),
  //     WaitingListEntity(
  //       id: 2,
  //       shopId: 1,
  //       tablingType: '카운터',
  //       phoneNumber: '010-9876-5432',
  //       personnel: 2,
  //       createdAt: DateTime.now(),
  //       updatedAt: DateTime.now(),
  //       deletedAt: DateTime.now(),
  //     ),
  //   ];
  // }

  List<WaitingListEntity> get waitingList => _waitingList;
}
