import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_year_web/controller/c_record.dart';
import 'package:new_year_web/logic/letter.dart';
import 'package:new_year_web/logic/local_user.dart';
import 'package:new_year_web/theme/no_user_panel.dart';
import 'package:new_year_web/theme/router.dart';

class RecordListScreen extends StatelessWidget {
  const RecordListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var con = Get.put(RecordController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("我的创作"),
        actions: [
          IconButton(
              onPressed: (){
                con.refreshData();
              },
              icon: const Icon(Icons.refresh),
              tooltip: "刷新",
          )
        ],
      ),
      body: hasUser() ? allWorks(context, con) : notLogin(context),
    );
  }

  Widget allWorks(BuildContext context, RecordController controller){
    return Obx(() => ListView.builder(
        itemCount: controller.myWorks.length,
        itemBuilder: (mContext, index){
          return ListTile(
            leading: const Icon(Icons.file_present),
            title: Text("致 ${controller.myWorks[index]["target_name"]}"),
            subtitle: Text("将在${controller.myWorks[index]["opening_time"]}对对方生效"),
            trailing: PopupMenuButton(
                tooltip: "更多操作",
                itemBuilder: (bc) => <PopupMenuEntry<RecordOperation>>[
                  const PopupMenuItem(
                      value: RecordOperation.edit,
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 4, height: 1),
                          Text("编辑")
                        ],
                      )
                  ),
                  const PopupMenuItem(
                      value: RecordOperation.view,
                      child: Row(
                        children: [
                          Icon(Icons.remove_red_eye),
                          SizedBox(width: 4, height: 1),
                          Text("预览")
                        ],
                      )
                  ),
                  const PopupMenuItem(
                      value: RecordOperation.delete,
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(width: 4, height: 1),
                          Text("删除")
                        ],
                      )
                  )
                ],
              onSelected: (op) => {
                  switch(op){
                    RecordOperation.edit => {
                      Get.toNamed(RouterHelper.worker, arguments: {
                        "code": "edit", "id": controller.singleId(index)
                      })
                    },
                    RecordOperation.delete => {
                      controller.deleteDialog(mContext, index)
                    },
                    RecordOperation.view => {
                      letterData = controller.myWorks[index],
                      Get.toNamed(RouterHelper.stage, arguments: {
                        "a": controller.myWorks[index]["code"].toString(),
                        "mode": "preview"
                      })
                    },
                  }
              },
            ),
          );
        }
    ));
  }
}

enum RecordOperation { edit, view, delete }