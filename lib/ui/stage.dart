import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_year_web/controller/c_stage.dart';
import 'package:new_year_web/logic/letter.dart';
import 'package:new_year_web/logic/local_user.dart';
import 'package:new_year_web/theme/no_in_time.dart';
import 'package:new_year_web/theme/no_user_panel.dart';

class StageScreen extends StatelessWidget {
  const StageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var target = Get.arguments["a"].toString();
    var mode = Get.arguments["mode"].toString();
    var con = Get.put(StageController(target: target, mode: mode));
    return Scaffold(
      body: setStage(context, con, target),
      floatingActionButton: con.showFab()
          ? FloatingActionButton(
              onPressed: () {
                letterData = null;
                Get.back();
              },
              child: const Icon(Icons.arrow_back_outlined),
            )
          : null,
      bottomNavigationBar: setBar(con, context)
      //musicPlayer(officialData["bgm"].toString()),
    );
  }

  Widget setBar(StageController controller, BuildContext context){
    return Row(
      children: [
        controller.needMusicWindow() ? controller.needMusic() : const SizedBox(width: 1, height: 1),
        Obx(() => Visibility(
            replacement: ElevatedButton(
                onPressed: (){
                  Clipboard.setData(ClipboardData(text: controller.showAllWords()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("已将内容添加到你的剪贴板上"))
                  );
                },
                child: const Text("下载全文")
            ),
            visible: controller.showType.value,
            child: controller.needMusicWindow() ?
            Text("${controller.getName()}为你准备了一首随附音乐") :
            const Text("")
        ))
      ],
    );
  }

  Widget setStage(
      BuildContext context, StageController controller, String code) {
    if (hasUser() || code == "0000") {
      if (controller.isTimeSuitable()) {
        controller.playMusic();
        controller.changeBgIfNeed();
        return SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(image: controller.bg.value),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: controller.showType.value,
                        replacement: Text(
                          controller.showAllWords(),
                          style: controller.getTextStyle(),
                        ),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DefaultTextStyle(
                                style: controller.getTextStyle(),
                                child: AnimatedTextKit(
                                  animatedTexts: controller.getWordContext(),
                                  isRepeatingAnimation: false,
                                  onFinished: () {
                                    controller.playMusic();
                                    controller.showType.value = false;
                                  },
                                ))),
                      ),
                    ],
                  ),
                ))));
      } else {
        return notInTime(context);
      }
    } else {
      return notLogin(context);
    }
  }
}
