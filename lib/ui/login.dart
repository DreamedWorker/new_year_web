import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_year_web/controller/CLogin.dart';
import 'package:new_year_web/logic/local_user.dart';
import 'package:new_year_web/theme/router.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var con = Get.put(CLogin());

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("登录"),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(RouterHelper.register);
                },
                icon: const Icon(Icons.app_registration),
                tooltip: "注册")
          ],
        ),
        body: IndexedStack(
          children: [
            SizedBox(
              width: mq.size.width,
              height: mq.size.height - 56,
              child: Column(
                children: [
                  const SizedBox(width: 1, height: 48),
                  Card(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: (mq.size.width / 2) + 50,
                          child: Column(
                            children: [
                              const Text(
                                "通过 Dream ID 登录",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 1, height: 16),
                              TextField(
                                controller: con.username.value,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Dream ID",
                                    prefixIcon: Icon(Icons.person)),
                              ),
                              const SizedBox(width: 1, height: 8),
                              TextField(
                                controller: con.password.value,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "密码",
                                    prefixIcon: Icon(Icons.password)),
                              ),
                              const SizedBox(width: 1, height: 16),
                              ElevatedButton(
                                  onPressed: () async {
                                    var a = await loginAccount(
                                        con.username.value.text,
                                        con.password.value.text);
                                    if (a) {
                                      Get.snackbar("提示", "登录成功，欢迎！");
                                      Get.offAndToNamed(RouterHelper.central);
                                    }
                                  },
                                  child: const Text("登录")),
                              const SizedBox(width: 1, height: 16),
                              const Text(
                                "Dream ID 是你为他人制作和查看他人为你制作的内容的唯一凭据，请妥善保存。",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
