import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("关于"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Image.asset(
                          "resource/logo_big.png",
                          width: 48,
                          height: 48,
                        ),
                        const Text(
                            "new_year_web Website Project",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text("Version 0.0.1"),
                      ],
                    ),
                )
              )
            ),
            const SizedBox(width: 1, height: 8,),
            Card(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            "开发人员和工具",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          leading: const Icon(Icons.perm_contact_cal),
                          title: const Text("梦之黯蓝（Yuanshine）"),
                          subtitle: const Text("Code, Design, Idea"),
                          trailing: const Icon(Icons.hub),
                          onTap: () async {
                            if(!await launchUrl(Uri.parse("https://github.com/DreamedWorker"))){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("无法启动该窗口，出现意外错误！"))
                              );
                            }
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.source),
                          title: const Text("开放源代码许可"),
                          subtitle: const Text("本网站应用的编写离不开Flutter和其他开源软件的支持"),
                          trailing: const Icon(Icons.open_in_new),
                          onTap: (){
                            Get.to(() => const LicensePage(
                              applicationName: "Happy New Year Website",
                              applicationVersion: "Version 0.0.1",
                            ));
                          },
                        ),
                      ],
                    ),
                ),
              ),
            ),
            const SizedBox(width: 1, height: 8,),
            ListTile(
              leading: const Icon(Icons.gite),
              title: const Text("访问软件仓库"),
              subtitle: const Text("查看软件源码或提出Issue（文字仅限简体中文）"),
              trailing: const Icon(Icons.open_in_browser),
              onTap: (){},
            ),
            const SizedBox(width: 1, height: 8,),
            const Text("本软件系开源软件，你与其的交互均系自愿行为，本软件不含任何担保。")
          ],
        ),
      )
    );
  }
}