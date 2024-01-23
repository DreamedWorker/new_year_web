import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_year_web/controller/c_workshop.dart';
import 'package:new_year_web/logic/local_user.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/no_user_panel.dart';

class WorkshopScreen extends StatelessWidget {
  const WorkshopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var opType = Get.arguments["code"];
    var opTarget = Get.arguments["id"];
    var con = Get.put(WorkshopControl(opTarget: opTarget, opCode: opType));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("编写文案"),
      ),
      body: hasUser() ? pageContext(context, con) : notLogin(context),
      floatingActionButton: hasUser() ?
      FloatingActionButton(
          onPressed: () async {
            if(con.noneOfNull()){
              if(opType == "create") {
                if (await con.onlyOneCode(con.code.value.text) == 0) {
                  con.submitChanges();
                } else {
                  Get.snackbar("错误", "你提供的查看代码不是唯一的！");
                }
              } else if (opType == "edit"){
                con.submitChanges();
              }
            } else {
              Get.snackbar("错误", "除背景和背景音乐外，其他项目都要填写！");
            }
          },
          tooltip: "提交",
          child: const Icon(Icons.check),
      ) : null,
    );
  }

  Widget pageContext(BuildContext context, WorkshopControl con){
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
      child: Column(
        children: [
          Card(
            elevation: 4,
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("基本信息",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 1, height: 8),
                    TextField(
                      controller: con.target_name.value,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        labelText: "对方昵称",
                        helperText: "你如何称呼对方",
                      ),
                    ),
                    const SizedBox(width: 1, height: 4),
                    TextField(
                      controller: con.your_name.value,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.contacts_sharp),
                        labelText: "你的昵称",
                        helperText: "你在对方处显示的昵称",
                      ),
                    ),
                    const SizedBox(width: 1, height: 4),
                    ListTile(
                      leading: const Icon(Icons.calendar_month),
                      title: const Text("设置可见时间"),
                      subtitle: const Text("设置对方可见的最早时间，你不受此时间的限制"),
                      onTap: (){
                        selectOpeningTime(context, con);
                      },
                    ),
                    Obx(() => Text("时间${con.opening_time.value.toString()}")),
                    const SizedBox(width: 1, height: 4),
                    TextField(
                      controller: con.code.value,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.code),
                        labelText: "查看代码",
                        helperText: "不能为0000且必须是唯一的，由数字和字母组成，区分大小写。",
                      ),
                    ),
                    const SizedBox(width: 1, height: 4),
                    TextField(
                      controller: con.key.value,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.key),
                        labelText: "二次验证Key",
                        helperText: "用于防止在代码被猜到后的二次验证。",
                      ),
                    ),
                  ],
                ),
            )
          ),
          const SizedBox(width: 1, height: 8),
          Card(
            elevation: 4,
            color: Theme.of(context).colorScheme.tertiaryContainer,
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("展示内容",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 1, height: 8),
                    TextField(
                      controller: con.bg.value,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.image),
                        labelText: "背景图",
                        helperText: "输入背景图的直链，如果输入多个则使用【中文分号】分隔，如果输入的链接无法打开则会以我们的默认背景代替。",
                      ),
                    ),
                    const SizedBox(width: 1, height: 8),
                    TextField(
                      controller: con.bgm.value,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.music_note),
                        labelText: "背景音乐",
                        helperText: "输入背景音乐的链接，只能输入一个，不必须。如要填，仅支持网易云的外链播放器所指链接。",
                        suffixIcon: IconButton(
                            onPressed: (){
                              showBgmHelp(context);
                            },
                            icon: const Icon(Icons.help)
                        )
                      ),
                    ),
                    const SizedBox(width: 1, height: 8),
                    TextField(
                      controller: con.color.value,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.color_lens),
                        labelText: "展示文字的颜色",
                        helperText: "输入颜色的RGB代码，用英文逗号隔开（如：12,13,255）。如果你不知道有哪些数码，可以点按本输入框右侧的打开按钮查看。",
                        suffixIcon: IconButton(
                            onPressed: (){
                              launchUrl(Uri.parse("https://tool.vpsche.com/hexrgb/?eqid=981c7944000239df000000056440ff46&btwaf=55308911"));
                            },
                            icon: const Icon(Icons.open_in_browser)
                        )
                      ),
                    ),
                    const SizedBox(width: 1, height: 8),
                    TextField(
                      controller: con.words.value,
                      maxLines: 15,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.smart_display_outlined),
                        labelText: "要展示的内容",
                        helperText: "切勿使用回车换行，如果需要换行请使用英文的@符号代替回车换行。如果需要加页，在文末输入英文的加号后直接输入下一页的内容即可。",
                      ),
                    ),
                  ],
                ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> selectOpeningTime(BuildContext context, WorkshopControl control) async {
    var datetime = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2024, 2, 26),
        initialDate: DateTime.now(),
        helpText: "对方将在早于你设置的日期内无法根据你提供的代码访问内容",
        confirmText: "确认",
        cancelText: "取消"
    );
    if (datetime != null) {
      Get.snackbar("提示", "你已经将时间修改为${datetime.toString()}");
      control.opening_time.value = datetime;
    } else {
      Get.snackbar("提示", "由于你尚未选择，我们将以今天的日期用作最早时间。");
    }
  }

  Future<void> showBgmHelp(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (bc){
          return AlertDialog(
            icon: const Icon(Icons.music_note),
            title: const Text("如何添加背景音乐"),
            content: const SingleChildScrollView(
              child: Text("通过网页版网易云音乐选择你需要共享的音乐，然后单击页面上的【生成外链播放器】"
                  "然后选择【287x32】大小，并将下方HTML代码中src参数中的【//music.....66】的引号内"
                  "内容全部复制到此文本框，并在其开头加上【https:】即可。"),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(bc).pop();
                  },
                  child: const Text("知悉")
              )
            ],
          );
        }
    );
  }
}