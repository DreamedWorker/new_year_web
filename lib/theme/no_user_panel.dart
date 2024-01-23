import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget notLogin(BuildContext context){
  var mq = MediaQuery.of(context);
  return SizedBox(
    width: mq.size.width,
    height: mq.size.height - 56,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 48,),
        const Text("错误", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
        const Text("你尚未登录！", style: TextStyle(fontSize: 16)),
        FilledButton(onPressed: (){Get.offAllNamed("/");}, child: const Text("返回首页"))
      ],
    ),
  );
}