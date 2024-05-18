import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/tabling_list.dart';

part 'tabling_data_source.g.dart';

@RestApi(baseUrl: "http://localhost:3000")
abstract class TablingDataSource {
  factory TablingDataSource(Dio dio, {String? baseUrl}) = _TablingDataSource;

  @GET("/tabling/waiting-list")
  Future<List<TablingList>> getTablingList();
}
