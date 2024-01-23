import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_year_web/logic/letter.dart';

Widget notInTime(BuildContext context){
  var mq = MediaQuery.of(context);
  return SizedBox(
    width: mq.size.width,
    height: mq.size.height - 56,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.access_time, size: 48,),
        const Text("提示", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
        const Text("开启本函的时间尚早！", style: TextStyle(fontSize: 16)),
        FilledButton(onPressed: (){
          letterData = null;
          Get.offAllNamed("/");
          },
            child: const Text("返回")
        )
      ],
    ),
  );
}