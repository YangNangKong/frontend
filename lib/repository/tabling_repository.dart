import '../model/tabling_list.dart';

abstract class TablingRepository {
  Future<List<TablingList>> getTablingList();
}
