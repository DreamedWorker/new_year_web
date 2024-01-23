import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:new_year_web/logic/letter.dart';
import 'package:new_year_web/logic/local_user.dart';
import 'package:new_year_web/theme/music_player.dart';

class StageController extends GetxController {
  StageController({required this.target, required this.mode});

  final String target;
  final String mode;
  var bg = const DecorationImage(
          image: AssetImage("resource/logo_big.png"), fit: BoxFit.fill)
      .obs;
  var showType = true.obs;

  String getName() {
    if (target == "0000") {
      return "开发者";
    } else {
      return letterData!["your_name"].toString();
    }
  }

  void changeBgIfNeed() {
    if (target == "0000") {
      var bgList = officialData["bg"].toString().split("；");
      if (bgList.isNotEmpty) {
        int a = 0;
        Timer.periodic(const Duration(seconds: 4), (timer) {
          if (a == bgList.length) {
            a = 0;
          }
          bg.value =
              DecorationImage(image: NetworkImage(bgList[a]), fit: BoxFit.fill);
          a = a + 1;
        });
      }
    } else {
      if (letterData!["bg"].toString() != "none") {
        var bgList = letterData!["bg"].toString().split("；");
        if (bgList.isNotEmpty) {
          int a = 0;
          Timer.periodic(const Duration(seconds: 4), (timer) {
            if (a == bgList.length) {
              a = 0;
            }
            bg.value = DecorationImage(
                image: NetworkImage(bgList[a]), fit: BoxFit.fill);
            a = a + 1;
          });
        }
      }
    }
  }

  bool needMusicWindow() {
    if (target == "0000") {
      return true;
    } else {
      if (letterData!["bgm"].toString() != "none") {
        return true;
      } else {
        return false;
      }
    }
  }

  List<TypewriterAnimatedText> getWordContext() {
    List<TypewriterAnimatedText> result = [];
    if (target == "0000") {
      var textGroup = officialData["words"].toString().replaceAll("@", "\n\n");
      var textPaged = textGroup.split("+");
      for (String a in textPaged) {
        result.add(TypewriterAnimatedText(a));
      }
      return result;
    } else {
      var textGroup = letterData!["words"].toString().replaceAll("@", "\n\n");
      var textPaged = textGroup.split("+");
      for (String a in textPaged) {
        result.add(TypewriterAnimatedText(a));
      }
      return result;
    }
  }

  TextStyle getTextStyle() {
    if (target == "0000") {
      var colorG = officialData["color"].toString().split(",");
      return TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(int.parse(colorG[0]), int.parse(colorG[1]),
              int.parse(colorG[2]), 1));
    } else {
      var colorG = letterData!["color"].toString().split(",");
      return TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(int.parse(colorG[0]), int.parse(colorG[1]),
              int.parse(colorG[2]), 1));
    }
  }

  String showAllWords() {
    if (target == "0000") {
      var textGroup = officialData["words"].toString().replaceAll("@", "\n\n");
      var textNoPage = textGroup.replaceAll("+", "\n\n\n");
      return textNoPage;
    } else {
      var textGroup = letterData!["words"].toString().replaceAll("@", "\n\n");
      var textNoPage = textGroup.replaceAll("+", "\n\n\n");
      return textNoPage;
    }
  }

  Widget needMusic() {
    if (target == "0000") {
      return musicPlayer(officialData["bg"].toString());
    } else {
      if (letterData!["bg"].toString() != "none") {
        return musicPlayer(letterData!["bg"].toString());
      } else {
        return const SizedBox(
          width: 1,
          height: 1,
        );
      }
    }
  }

  bool isTimeSuitable() {
    if(mode == "view") {
      if (target != "0000") {
        var cur = DateTime.now();
        var ti = letterData!["opening_time"].toString().split("-");
        var req = DateTime(
            int.parse(ti[0]), int.parse(ti[1]), int.parse(ti[2]));
        if (cur.isAtSameMomentAs(req) || cur.isAfter(req)) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  bool showFab() {
    return (hasUser() && isTimeSuitable()) || target == "0000";
  }

  Future<void> playMusic() async {
    final player = AudioPlayer();
    player.play(UrlSource("resource/sae.mp3"));
  }
}
