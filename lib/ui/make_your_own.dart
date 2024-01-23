import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Yours extends StatelessWidget {
  const Yours({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("你好制作人"),
          ElevatedButton(onPressed: () => { Get.snackbar("title", "message") }, child: Text("返回"))
        ],
      ),
    );
  }
}