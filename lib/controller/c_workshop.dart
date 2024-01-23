import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:new_year_web/logic/local_user.dart';

class WorkshopControl extends GetxController {


  WorkshopControl({required this.opCode, this.opTarget});

  var target_name = TextEditingController().obs;
  var your_name = TextEditingController().obs;
  var opening_time = DateTime.now().obs;
  var code = TextEditingController().obs;
  var bg = TextEditingController().obs;
  var bgm = TextEditingController().obs;
  var words = TextEditingController().obs;
  var key = TextEditingController().obs;
  var color = TextEditingController().obs;
  final String opCode;
  final String? opTarget;

  @override
  void onInit() async {
    super.onInit();
    if(opCode == "edit"){
      if(opTarget != null){
        LCQuery<LCObject> query = LCQuery("Posts");
        LCObject? result = await query.get(opTarget!);
        if (result != null){
          target_name.value.text = result["target_name"];
          your_name.value.text = result["your_name"];
          timeDeal(result["opening_time"]);
          code.value.text = result["code"];
          key.value.text = result["key"];
          words.value.text = result["words"];
          color.value.text = result["color"];
          if(result["bg"] != "none"){
            bg.value.text = result["bg"];
          }
          if(result["bgm"] != "none"){
            bgm.value.text = result["bgm"];
          }
        } else {
          Get.snackbar("错误", "加载目标对象时出错，请重试！");
        }
      } else {
        Get.snackbar("错误", "参数异常，你的操作可能非法，请重试！");
      }
    }
  }

  void timeDeal(String formattedTime){
    var a = formattedTime.split("-");
    opening_time.value = DateTime(int.parse(a[0]), int.parse(a[1]), int.parse(a[2]));
  }

  bool noneOfNull(){
    return target_name.value.text.isNotEmpty && your_name.value.text.isNotEmpty
      && words.value.text.isNotEmpty && code.value.text.isNotEmpty
        && key.value.text.isNotEmpty && color.value.text.isNotEmpty;
  }

  Future<int> onlyOneCode(String code) async {
    LCQuery<LCObject> query = LCQuery("Posts");
    query.whereEqualTo("code", code);
    List<LCObject>? results = await query.find();
    if(results != null){
      return results.length;
    } else {
      return 0;
    }
  }

  Future<void> submitChanges() async {
    if(opCode == "create") {
      LCObject obj = LCObject("Posts");
      obj["bg"] = bg.value.text.isNotEmpty ? bg.value.text : "none";
      obj["bgm"] = bgm.value.text.isNotEmpty ? bgm.value.text : "none";
      obj["code"] = code.value.text;
      obj["opening_time"] = opening_time.value.toString().substring(0, 10);
      obj["target_name"] = target_name.value.text;
      obj["words"] = words.value.text;
      obj["your_name"] = your_name.value.text;
      obj["owner"] = user!;
      obj["key"] = key.value.text;
      obj["color"] = color.value.text;
      var result = await obj.save();
      Get.snackbar("提示", "对象${result.objectId}保存成功");
    } else if (opCode == "edit" && opTarget != null){
      LCObject obj = LCObject.createWithoutData("Posts", opTarget!);
      obj["bg"] = bg.value.text.isNotEmpty ? bg.value.text : "none";
      obj["bgm"] = bgm.value.text.isNotEmpty ? bgm.value.text : "none";
      obj["code"] = code.value.text;
      obj["opening_time"] = opening_time.value.toString().substring(0, 10);
      obj["target_name"] = target_name.value.text;
      obj["words"] = words.value.text;
      obj["your_name"] = your_name.value.text;
      obj["owner"] = user!;
      obj["key"] = key.value.text;
      obj["color"] = color.value.text;
      var result = await obj.save();
      Get.snackbar("提示", "对象${result.objectId}修改成功");
    }
  }
}