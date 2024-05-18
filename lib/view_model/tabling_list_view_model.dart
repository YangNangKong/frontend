import 'package:flutter/cupertino.dart';

import '../model/tabling_list.dart';
import '../repository/tabling_repository.dart';

class TablingListViewModel extends ChangeNotifier {
  late final TablingRepository tablingRepository;
  List<TablingList> _tablingList = [];
  bool isLoading = false;

  TablingListViewModel({required this.tablingRepository});

  Future<void> fetchTablingList() async {
    isLoading = true;
    notifyListeners();
    try {
      _tablingList = await tablingRepository.getTablingList();
    } catch (error) {
      // Error handling
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // List<TablingListEntity> _tablingList = [
  //   TablingListEntity(
  //     id: 1,
  //     shopId: 1,
  //     tablingType: '테이블',
  //     phoneNumber: '010-1234-5678',
  //     personnel: 3,
  //     createdAt: DateTime.now(),
  //     updatedAt: DateTime.now(),
  //     deletedAt: DateTime.now(),
  //   ),
  //   TablingListEntity(
  //     id: 2,
  //     shopId: 1,
  //     tablingType: '카운터',
  //     phoneNumber: '010-9876-5432',
  //     personnel: 2,
  //     createdAt: DateTime.now(),
  //     updatedAt: DateTime.now(),
  //     deletedAt: DateTime.now(),
  //   ),
  // ];

  List<TablingList> get tablingList => _tablingList;
}
