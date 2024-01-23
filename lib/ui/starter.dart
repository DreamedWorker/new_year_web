import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:new_year_web/logic/letter.dart';
import 'package:new_year_web/logic/local_user.dart';
import 'package:new_year_web/theme/router.dart';

class Starter extends StatelessWidget {
  const Starter({super.key});

  @override
  Widget build(BuildContext context) {
    letterData = null;
    return Scaffold(
      appBar: AppBar(
        title: const Text("新年信函"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (!hasUser()) {
                Get.toNamed(RouterHelper.login);
              } else {
                Get.toNamed(RouterHelper.central);
              }
            },
            icon: const Icon(Icons.create),
            tooltip: "创做",
          ),
          IconButton(
            onPressed: () {
              if (!hasUser()) {
                Get.toNamed(RouterHelper.login);
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("你已登录")));
              }
            },
            icon: const Icon(Icons.login),
            tooltip: "登录",
          ),
        ],
      ),
      body: Tester(context),
    );
  }
}

Widget Tester(BuildContext con) {
  var control = TextEditingController();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: MediaQuery.of(con).size.width,
        height: MediaQuery.of(con).size.height * 0.9 - 56,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //     onPressed: () => {
            //       Get.toNamed(RouterHelper.maker)
            //     },
            //     child: const Text("开始制作")
            // ),
            const Text(
              "新年快乐",
              style: TextStyle(
                  color: Color.fromRGBO(240, 75, 34, 1),
                  fontSize: 48,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 350,
              child: TextField(
                controller: control,
                decoration: InputDecoration(
                    labelText: "输入你的代码",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.card_giftcard),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          if (control.text.isNotEmpty) {
                            if (control.text == "0000") {
                              _showIntroDialog(
                                  con, "屏幕前的你", "开发者", "0000", "n");
                            } else {
                              if (hasUser()) {
                                LCQuery<LCObject> query = LCQuery("Posts");
                                query.whereEqualTo("code", control.text);
                                var res = await query.first();
                                if (res != null) {
                                  letterData = res;
                                  _showIntroDialog(
                                      con,
                                      res["target_name"],
                                      res["your_name"],
                                      control.text,
                                      res["key"]);
                                } else {
                                  ScaffoldMessenger.of(con).showSnackBar(
                                      const SnackBar(
                                          content: Text("没有找到对应的内容")));
                                }
                              } else {
                                ScaffoldMessenger.of(con).showSnackBar(
                                    const SnackBar(
                                        content: Text("你尚未登录，无权查看任何内容。")));
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(con).showSnackBar(
                                const SnackBar(content: Text("代码不得为空")));
                          }
                        },
                        icon: const Icon(Icons.arrow_forward)),
                    helperText: "你也可以输入0000来查看官方演示"),
              ),
            ),
          ],
        ),
        //decoration: BoxDecoration(color: Theme.of(con).colorScheme.onTertiaryContainer),
      ),
      SizedBox(
        width: MediaQuery.of(con).size.width,
        height: MediaQuery.of(con).size.height * 0.1,
        child: const Column(
          children: [
            Text("(c) Copyright Yuanshine. 2024-present. All right reversed."),
            Text("所有的数据将会保存到2024年2月25日"),
          ],
        ),
      )
    ],
  );
}

Future<void> _showIntroDialog(
    BuildContext cn, String title, String nicName, String target, String key) {
  var mKey = TextEditingController();
  if (target == "0000") {
    mKey.text = "官方演示内容，无需查看key。";
  }
  return showDialog<void>(
      context: cn,
      barrierDismissible: false,
      builder: (BuildContext bc) {
        return AlertDialog(
          title: Text("你收到了来自 $nicName 的祝愿"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("$title："),
                const Text("在农历2023年即将走到终点之际，还有很多话想向对你说。\n"
                    "注意开启后切勿调整窗口大小。"),
                const SizedBox(
                  width: 1,
                  height: 4,
                ),
                TextField(
                  controller: mKey,
                  enabled: target != "0000" ? true : false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "输入查看key以继续",
                      prefixIcon: Icon(Icons.key)),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (target == "0000") {
                    Navigator.of(bc).pop();
                    Get.toNamed(RouterHelper.stage, arguments: {
                      "a": target, "mode": "view"
                    });
                    return;
                  }
                  if (mKey.text == key) {
                    Navigator.of(bc).pop();
                    Get.toNamed(RouterHelper.stage, arguments: {"a": target});
                  } else {
                    ScaffoldMessenger.of(bc).showSnackBar(
                        const SnackBar(content: Text("查看key不正确")));
                  }
                },
                child: const Text("启函")),
            TextButton(
                onPressed: () {
                  letterData = null;
                  Navigator.of(bc).pop();
                },
                child: const Text("暂存"))
          ],
          elevation: 4,
          icon: const Icon(Icons.card_giftcard),
        );
      });
}
