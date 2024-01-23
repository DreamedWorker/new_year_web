import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

Widget musicPlayer(String url){
  var nUrl = url.substring(6);
  var front = """
  <iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=298 height=52 src="//music.163.com/outchain/player?type=2&id=1495115654&auto=1&height=32"></iframe>
  """;
  var end = """"></iframe>""";
  var test = """
  <h3>Heading</h3>
  <p>
    A paragraph with <strong>strong</strong>, <em>emphasized</em>
    and <span style="color: red">colored ${nUrl}</span> text.
  </p>""";
  print("音乐播放器注册！");
  return HtmlWidget(
    //front + url + end,
    front,
    renderMode: RenderMode.column,
  );
}