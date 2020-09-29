
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterSocial {
  static const MethodChannel _channel =
      const MethodChannel('kaige.com/social');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 传入QQ号
  static Future<bool> goToQQChat(String qqNum)async{
    Map<String, dynamic> map = {
      'qqNum': qqNum,
    };
    return _channel.invokeMethod<bool>('goToQQChat',map);
  }

  /// 传入qq群号和qq群的key(在这里获取https://qun.qq.com/join.html)
  static Future<bool> goToQQGroup(String qqGroupNum, String qqGroupKey)async{
    Map<String, dynamic> map = {
      'qqGroupNum': qqGroupNum,
      'qqGroupKey': qqGroupKey,
    };
    return _channel.invokeMethod<bool>('goToQQGroup',map);
  }
}
