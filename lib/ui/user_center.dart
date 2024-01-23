import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:new_year_web/logic/local_user.dart';
import 'package:new_year_web/theme/no_user_panel.dart';
import 'package:new_year_web/theme/router.dart';

class UserCenterScreen extends StatelessWidget {
  const UserCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("用户中心"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(onPressed: (){
              logout();
              Get.back();
            },
              icon: const Icon(Icons.logout),
              tooltip: "登出",
          )
        ],
      ),
      body: hasUser() ? ucContext(context) : notLogin(context)
    );
  }

  Widget ucContext(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: ListView(
        children: [
          Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    const Icon(Icons.account_circle),
                    const SizedBox(width: 16, height: 1,),
                    Text(
                      user!.username!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    )
                  ],
                ),
              )
          ),
          const SizedBox(width: 1, height: 16,),
          ListTile(
            leading: const Icon(Icons.note_add),
            title: const Text("创作一篇"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: (){
              Get.toNamed(RouterHelper.worker, arguments: { "code": "create"} );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("创作记录"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: (){
              Get.toNamed(RouterHelper.works);
            },
          ),
          const SizedBox(width: 1, height: 32,),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text("关于我们"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: (){
              Get.toNamed(RouterHelper.about);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text("删除 Dream ID"),
            trailing: const Icon(Icons.close),
            subtitle: const Text("这将使你的所有创作不再可见"),
            iconColor: Theme.of(context).colorScheme.error,
            textColor: Theme.of(context).colorScheme.error,
            onTap: (){
              // html.FileUploadInputElement upload = html.FileUploadInputElement();
              // upload.multiple = false;
              // upload.click();
              // upload.onChange.listen((event) async {
              //   html.File? file = upload.files?.first;
              //   if(file != null){
              //     final render = html.FileReader();
              //     render.readAsArrayBuffer(file);
              //     await render.onLoad.first;
              //     var data = render.result as Uint8List;
              //     LCFile lcFile = LCFile.fromBytes(file.name, data);
              //     await lcFile.save();
              //     print(lcFile.url);
              //   }
              // });
              showDeleteAccount(context);
            },
          ),
        ],
      ),
    );
  }
}

Future<void> showDeleteAccount(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (builder){
        return AlertDialog(
          title: const Text("警告"),
          content: const Text("删除Dream ID 将会删除全部内容且无法找回，要继续吗？"),
          actions: [
            TextButton(
                onPressed: () async {
                  LCQuery<LCObject> query = LCQuery("Posts");
                  query.whereEqualTo("owner", user!);
                  var result = await query.find();
                  if(result != null){
                    for(LCObject single in result){
                      await single.delete();
                    }
                  }
                  await user!.delete();
                  Navigator.of(context).pop();
                  Get.snackbar("提示", "此Dream ID已删除完成！");
                  user = null;
                  Get.back();
                },
                child: const Text("确定")),
            TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("取消"))
          ],
        );
      }
  );
}