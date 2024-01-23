import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:new_year_web/logic/local_user.dart';
import 'package:new_year_web/theme/color_schemes.g.dart';
import 'package:new_year_web/theme/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    initUserData();

    return GetMaterialApp(
      title: 'Happy New Year!',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      initialRoute: RouterHelper.initial,
      getPages: RouterHelper.router,
      //home: const Starter(),
    );
  }
}
