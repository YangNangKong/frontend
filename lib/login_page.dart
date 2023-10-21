import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text(
            "YNK Tabling",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Image.network(
                  "https://tumblbug-pci.imgix.net/c854afea9f2858de047ed6c4037079a86d8e85c2/4ca37de55d78bcfd0d96d1a157d808698c143913/1dfc9a35b736b925bc75efe3f532a229991851d6/855bab0e-496b-4693-a436-4472cf71184c.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=3763fe763047bf77397bc94117ff2984",
                  width: 400,
                  height: 400,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "이메일",
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "비밀번호",
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 24),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black38
                    ),
                    child: Text("관리자 로그인")
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}