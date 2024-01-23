import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';


LCUser? user;
String tn = "测试用户名";

void initUserData() async {
  LCUser? currentUser = await LCUser.getCurrent();
  if (currentUser != null){
    user = currentUser;
  }
}

bool hasUser(){
  return user != null;
}

Future<bool> loginAccount(String un, String pw) async {
  print(dealPw(pw));
  if (un.isEmpty || pw.isEmpty){
    Get.snackbar("登录失败", "账号或密码不得为空");
    return false;
  }
  try {
    // 登录成功
    LCUser nUser = await LCUser.login(un, dealPw(pw));
    user = nUser;
    return true;
  } on LCException catch (e) {
    // 登录失败（可能是密码错误）
    Get.snackbar("登录失败", "${e.code} : ${e.message}");
    return false;
  }
}

Future<bool> register(String un, String pw, String em) async {
  LCUser neoUser = LCUser();
  neoUser.username = un;
  neoUser.password = pw;
  neoUser.email = em;
  try {
    var b = await neoUser.signUp();
    user = b;
    return true;
  } on LCException catch (e){
    Get.snackbar("错误", "注册时出现了一个错误：${e.message}");
    return false;
  }
}

String dealPw(String ori){
  List<int> bytes = utf8.encode(ori);
  crypto.Digest md5 = crypto.md5.convert(bytes);
  return md5.toString();
}

void logout(){
  LCUser.logout();
  user = null;
}