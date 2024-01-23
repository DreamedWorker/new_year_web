import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:new_year_web/logic/local_user.dart';

class RecordController extends GetxController {
  var myWorks = <LCObject>[].obs;

  @override
  void onInit() async {
    super.onInit();
    getData();
  }

  void refreshData() async {
    Get.snackbar("提示", "我们正在刷新数据");
    getData();
  }

  void getData() async {
    LCQuery<LCObject> query = LCQuery("Posts");
    query.whereEqualTo("owner", user);
    var temp = await query.find();
    if (temp != null){
      myWorks.value = temp;
    }
  }

  String singleId(int index) => myWorks[index].objectId!;

  Future<void> deleteDialog(BuildContext context, int index) async {
    return showDialog<void>(
        context: context,
        builder: (builder){
          return AlertDialog(
            icon: const Icon(Icons.dangerous),
            title: const Text("你确定要删除吗？"),
            content: const Text("此操作一旦完成无法找回，且将使对方无法查看此内容。"),
            actions: [
              TextButton(
                  onPressed: (){Get.back();},
                  child: const Text("取消")
              ),
              TextButton(
                  onPressed: () async {
                    LCObject target = LCObject.createWithoutData("Posts", myWorks[index].objectId!);
                    await target.delete();
                    getData();
                    Get.back();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("删除成功"))
                    );
                  },
                  child: const Text("确定")
              )
            ],
          );
        }
    );
  }
}