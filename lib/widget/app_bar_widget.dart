import 'package:flutter/material.dart';
import 'package:flutter_application/token_manager.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      title: Text(
        "YNK Tabling",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      actions: [
        Tooltip(
          message: '로그아웃',
          child: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              TokenManager.removeToken();
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
        ),
      ],
    );
  }
}
