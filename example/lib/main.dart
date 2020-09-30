import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_social/flutter_social.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterSocial.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("点击跳转QQ联系人"),
                  onPressed: ()async{
                    //TODO 写上你想跳转的QQ号
                    bool isSuccess = await FlutterSocial.goToQQChat("QQ号");
                    print("goToQQChat isSuccess: $isSuccess");
                  }
              ),
              MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("点击跳转QQ群"),
                  onPressed: ()async{
                    //TODO 写上你想跳转的QQ群号和Key值
                    bool isSuccess = await FlutterSocial.goToQQGroup("QQ群号","QQ群对应的Key值");
                    print("goToQQGroup isSuccess: $isSuccess");
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
