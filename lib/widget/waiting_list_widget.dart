import 'package:flutter/material.dart';
import 'package:flutter_application/widget/app_bar_widget.dart';
import 'package:flutter_application/widget/waiting_list_card_widget.dart';
import 'package:provider/provider.dart';

import '../view_model/WatingListViewModel.dart';

class WaitingListWidget extends StatelessWidget {
  const WaitingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WaitingListViewModel>(
      create: (_) => WaitingListViewModel(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBarWidget(
            currentPage: '/waitingList',
          ),
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
              ...context.read<WaitingListViewModel>().waitingList.map(
                  (waitingData) =>
                      WaitingListCardWidget(waitingListEntity: waitingData)),
            ],
          ),
        );
      },
    );
  }
}
