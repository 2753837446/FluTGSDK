import 'dart:async';

import 'package:flutter/services.dart';
import 'src/Response.dart';


final MethodChannel _channel = const MethodChannel('ftgsdk')
  ..setMethodCallHandler(_handler);

Future<String> get platformVersion async {
  final String version = await _channel.invokeMethod('getPlatformVersion');
  return version;
}

/// preload Success  result is scenes
StreamController<PreloadResponse> _preloadSuccessController =
new StreamController.broadcast();

Stream<PreloadResponse> get preloadSuccessCallback =>
    _preloadSuccessController.stream;

//preload failed
StreamController<PreloadResponse> _preloadFailedController =
new StreamController.broadcast();

Stream<PreloadResponse> get preloadFailedCallback =>
    _preloadFailedController.stream;

//AwardLoaded
StreamController<PreloadResponse> _awardVideoLoadedController =
new StreamController.broadcast();

Stream<PreloadResponse> get awardVideoLoadedCallback =>
    _awardVideoLoadedController.stream;

//interstitial loaded
StreamController<PreloadResponse> _interstitialLoadedController =
new StreamController.broadcast();

Stream<PreloadResponse> get interstitialLoadedCallback =>
    _interstitialLoadedController.stream;

//interstitialVideo loaded
StreamController<PreloadResponse> _interstitialVideoLoadedController =
new StreamController.broadcast();

Stream<PreloadResponse> get interstitialVideoLoadedCallback =>
    _interstitialVideoLoadedController.stream;

//show success
StreamController<TgSDKResponse> _showSuccessController =
new StreamController.broadcast();

Stream<TgSDKResponse> get showSuccessCallback => _showSuccessController.stream;

//show failed
StreamController<TgSDKResponse> _showFailedController =
new StreamController.broadcast();

Stream<TgSDKResponse> get showFailedCallback => _showFailedController.stream;

//on adClick
StreamController<TgSDKResponse> _adClickController =
new StreamController.broadcast();

Stream<TgSDKResponse> get adClickCallback => _adClickController.stream;

//on adClose
StreamController<TgSDKResponse> _adCloseController =
new StreamController.broadcast();

Stream<TgSDKResponse> get adCloseCallback => _adCloseController.stream;

Future<dynamic> _handler(MethodCall call) {
  print("Fluttertgsdk:   " + call.method);
  if ("preloadSuccess" == call.method) {
    _preloadSuccessController.add(PreloadResponse.fromMap(call.arguments));
  } else if ("preloadFailed" == call.method) {
    _preloadFailedController.add(PreloadResponse.fromMap(call.arguments));
  } else if ("awardVideoLoaded" == call.method) {
    _awardVideoLoadedController.add(PreloadResponse.fromMap(call.arguments));
  } else if ("interstitialLoaded" == call.method) {
    _interstitialLoadedController.add(PreloadResponse.fromMap(call.arguments));
  } else if ("interstitialVideoLoaded" == call.method) {
    _interstitialVideoLoadedController
        .add(PreloadResponse.fromMap(call.arguments));
  } else if ("onShowSuccess" == call.method) {
    _showSuccessController.add(TgSDKResponse.fromMap(call.arguments));
  } else if ("onShowFailed" == call.method) {
    _showFailedController.add(TgSDKResponse.fromMap(call.arguments));
  } else if ("onADClick" == call.method) {
    _adClickController.add(TgSDKResponse.fromMap(call.arguments));
  } else if ("onADClose" == call.method) {
    _adCloseController.add(TgSDKResponse.fromMap(call.arguments));
  } else {}
  return Future.value(true);
}

preload(String appid, [String channelId]) {
  if (channelId == null || "" == channelId) {
    channelId = "10053";
  }
  var invokeMethod = _channel.invokeMethod(
      "preload", <String, dynamic>{"appid": appid, "channelId": channelId});
  invokeMethod.then((data) {
    print(data);
  });
}

Future<dynamic> couldShow(String scene) async {
  return await _channel
      .invokeMethod("couldShow", <String, dynamic>{"scene": scene});
}

showAd(String scene) {
  _channel.invokeMethod("showAd", <String, dynamic>{"scene": scene});
}

showTestView(String scene) {
  _channel.invokeMethod("showTestView", <String, dynamic>{"scene": scene});
}

closeBanner(String scene) {
  _channel.invokeMethod("closeBanner", <String, dynamic>{"scene": scene});
}

setBannerConfig(String scene, String type, int x, int y, int width, int height,
    int interval) {
  _channel.invokeMethod("setBannerConfig", <String, dynamic>{
    "scene": scene,
    "type": type,
    "x": x,
    "y": y,
    "width": width,
    "height": height,
    "interval": interval
  });
}
