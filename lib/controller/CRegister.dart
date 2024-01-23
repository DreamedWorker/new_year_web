import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CRegister extends GetxController {
  var un = TextEditingController().obs;
  var pw1 = TextEditingController().obs;
  var pw2 = TextEditingController().obs;
  var em = TextEditingController().obs;

  bool asSame() => pw1.value.text == pw2.value.text;
  
  bool isEmail() => RegExp(r"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$").hasMatch(em.value.text);

  bool notEmpty(){
    return un.value.text.isNotEmpty && pw1.value.text.isNotEmpty &&
        pw2.value.text.isNotEmpty && em.value.text.isNotEmpty;
  }
}