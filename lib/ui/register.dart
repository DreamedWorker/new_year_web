import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_year_web/controller/CRegister.dart';
import 'package:new_year_web/logic/local_user.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var con = Get.put(CRegister());

    return Scaffold(
      appBar: AppBar(
        title: const Text("获取 Dream ID"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined),
          tooltip: "返回",
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if(con.notEmpty()) {
              if (con.asSame() && con.isEmail()) {
                if(await register(con.un.value.text, dealPw(con.pw1.value.text), con.em.value.text)){
                  Get.snackbar("提示", "注册成功");
                  Get.back();
                }
              } else {
                Get.snackbar("错误", "密码前后不一致或电子邮箱地址不合法");
              }
            } else {
              Get.snackbar("警告", "所有的文本框都应当按照要求填充。");
            }
          },
          tooltip: "注册",
          child: const Icon(Icons.check),
      ),
      body: SizedBox(
        width: mq.size.width,
        height: mq.size.height - 56,
        child: Column(
          children: [
            const SizedBox(width: 1, height: 24),
            SizedBox(
              width: (mq.size.width / 2) + 50,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Text(
                          "你与美好的世界，就差一步",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                      ),
                      const SizedBox(width: 1, height: 16),
                      Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            children: [
                              TextField(
                                controller: con.un.value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "唯一 Dream ID",
                                  helperText: "不得包含汉字（包括汉字字符）和除下划线以外的字符",
                                  prefixIcon: Icon(Icons.account_circle)
                                ),
                              ),
                              const SizedBox(width: 1, height: 8),
                              TextField(
                                controller: con.pw1.value,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "密码",
                                    helperText: "不得少于8个字符",
                                    prefixIcon: Icon(Icons.password)
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(width: 1, height: 8),
                              TextField(
                                controller: con.pw2.value,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "确认密码",
                                    helperText: "再输入一次密码以确认",
                                    prefixIcon: Icon(Icons.password)
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(width: 1, height: 8),
                              TextField(
                                controller: con.em.value,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "电子邮箱地址",
                                    helperText: "它用于在你忘记密码时进行找回",
                                    prefixIcon: Icon(Icons.email)
                                ),
                              ),
                              const SizedBox(width: 1, height: 16),
                            ],
                          ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}