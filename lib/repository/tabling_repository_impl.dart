import 'package:flutter_application/repository/tabling_repository.dart';
import '../data/datasource/tabling_data_source.dart';
import '../model/tabling_list.dart';

class TablingRepositoryImpl implements TablingRepository {
  final TablingDataSource tablingDataSource;

  TablingRepositoryImpl(this.tablingDataSource);

  @override
  Future<List<TablingList>> getTablingList() async {
    try {
      return await tablingDataSource.getTablingList();
    } catch (error) {
      throw Exception('Failed to load tabling list: $error');
    }
  }
}
