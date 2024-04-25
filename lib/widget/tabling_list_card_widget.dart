import 'package:flutter/material.dart';

import '../entity/tabling_list_entity.dart';

class TablingListCardWidget extends StatelessWidget {
  TablingListEntity tablingListEntity;

  TablingListCardWidget(
      {super.key, required TablingListEntity this.tablingListEntity});

  @override
  Widget build(BuildContext context) {
    final TablingListEntity tablingListEntity = this.tablingListEntity;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '${tablingListEntity.id}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${tablingListEntity.phoneNumber}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${tablingListEntity.personnel}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_alert_rounded,
                          size: 15,
                        ),
                        SizedBox(width: 3),
                        Text('호출'),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () => {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.accessibility_new_outlined,
                          size: 15,
                        ),
                        SizedBox(width: 3),
                        Text('입장'),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xff97DB3D),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () => {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 15,
                        ),
                        SizedBox(width: 3),
                        Text('노쇼'),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xffDB4B25),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
