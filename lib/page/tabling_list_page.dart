import 'package:flutter/material.dart';
import 'package:flutter_application/widget/app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../view_model/tabling_list_view_model.dart';
import '../widget/tabling_list_card_widget.dart';

class TablingListPage extends StatelessWidget {
  const TablingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TablingListViewModel>(
      create: (_) => TablingListViewModel(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBarWidget(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                ),
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        '대기 번호',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '핸드폰 번호',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '인원 수',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '기능',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...context.read<TablingListViewModel>().tablingList.map(
                  (data) =>
                      TablingListCardWidget(tablingListEntity: data)),
            ],
          ),
        );
      },
    );
  }
}
