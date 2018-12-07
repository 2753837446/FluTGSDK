import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:ftgsdk/ftgsdk.dart' as TGSDK;
import 'package:fluro/fluro.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _scenes;
  String _currentScene = "";
  String log = "";

  @override
  void initState() {
    super.initState();

    TGSDK.preloadSuccessCallback.listen((data) {
      print("showSuccess   ${data.result}");
      TGSDK.setBannerConfig("banner0", "TGBannerNormal", 0, 400, -1, 200, 30);
      TGSDK.setBannerConfig("banner1", "TGBannerNormal", 0, 600, -1, 200, 30);
      setState(() {
        _scenes = data.result.split(",");
        _currentScene = _scenes[0];
      });
    });

    TGSDK.preloadFailedCallback.listen((data) {});
    TGSDK.awardVideoLoadedCallback.listen((data) {
      setState(() {
        log += "awardVideoLoadedCallback   + ${data.result}\n";
      });
    });
    TGSDK.interstitialLoadedCallback.listen((data) {
      setState(() {
        log += "interstitialLoadedCallback   + ${data.result}\n";
      });
    });
    TGSDK.interstitialVideoLoadedCallback.listen((data) {
      setState(() {
        log += "interstitialVideoLoadedCallback   + ${data.result}\n";
      });
    });
    TGSDK.showSuccessCallback.listen((data) {
      setState(() {
        log += "showSuccessCallback   + ${data.result}\n";
      });
    });
    TGSDK.showFailedCallback.listen((data) {
      setState(() {
        log += "showFailedCallback   + ${data.result}\n";
      });
    });
    TGSDK.adClickCallback.listen((data) {
      setState(() {
        log += "adClickCallback   + ${data.result}\n";
      });
    });
    TGSDK.adCloseCallback.listen((data) {
      setState(() {
        log += "adCloseCallback   + ${data.result}\n${data.couldReward}\n";
      });
    });
  }

  void _lastScene() {
    var indexOf = _scenes.indexOf(_currentScene);
    if (indexOf != 0) {
      setState(() {
        _currentScene = _scenes[indexOf - 1];
      });
      print("$_currentScene \n $indexOf");
    }
  }

  void _nextScene() {
    var indexOf = _scenes.indexOf(_currentScene);
    if (indexOf != _scenes.length - 1) {
      setState(() {
        _currentScene = _scenes[indexOf + 1];
      });
      print("$_currentScene \n $indexOf");
    }
  }

  void _preload() {
    if (Platform.isAndroid){
      TGSDK.preload("59t5rJH783hEQ3Jd7Zqr");
    }else if (Platform.isIOS){
      TGSDK.preload("59t5rJH783hEQ3Jd7Zqr", null);
    }
  }

  void _showAd() {
    setState(() {
      log = "";
    });
    TGSDK.couldShow(_currentScene).then((data) {
      if (data is bool) {
        print("bool  ---------");
      }
      print(data);
    });
    TGSDK.showAd(_currentScene);
  }

  void _showTestView() {
    setState(() {
      log = "";
    });
    TGSDK.showTestView(_currentScene);
  }

  void _closeBanner() {
    TGSDK.closeBanner(_currentScene);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 80),
          child: new Column(
            children: <Widget>[
              new Text(_currentScene),
              new Container(
                margin: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new RaisedButton(
                      onPressed: _lastScene,
                      child: Text("Last Scene"),
                    )),
                    new Expanded(
                        child: new RaisedButton(
                      onPressed: _nextScene,
                      child: Text("Nest Scene"),
                    ))
                  ],
                ),
              ),
              new RaisedButton(
                onPressed: _preload,
                child: Text("Preload AD"),
              ),
              new RaisedButton(
                onPressed: _showAd,
                child: Text("Show AD"),
              ),
              new RaisedButton(
                onPressed: _showTestView,
                child: Text("Show TestView"),
              ),
              new RaisedButton(
                onPressed: _closeBanner,
                child: Text("CloseBanner"),
              ),
              new Text(log),
            ],
          ),
        ),
      ),
    );
  }
}
