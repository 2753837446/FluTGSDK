package com.yomob.ftgsdk;

import android.app.Activity;

import com.soulgame.sgsdk.tgsdklib.TGSDK;
import com.soulgame.sgsdk.tgsdklib.TGSDKUtil;
import com.soulgame.sgsdk.tgsdklib.ad.ITGADListener;
import com.soulgame.sgsdk.tgsdklib.ad.ITGPreloadListener;
import com.soulgame.sgsdk.tgsdklib.ad.TGBannerType;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FtgsdkPlugin */
public class FtgsdkPlugin implements MethodCallHandler {
  private static MethodChannel channel;
  private static WeakReference<Activity> mActivity;
  private ITGADListener adListener = new ITGADListener() {
    @Override
    public void onShowSuccess(String s) {

    }

    @Override
    public void onShowFailed(String s, String s1) {

    }

    @Override
    public void onADComplete(String s) {

    }

    @Override
    public void onADClick(String s) {

    }

    @Override
    public void onADClose(String s) {

    }

    @Override
    public void onShowSuccess(String s, String s1) {
      Map<String, String> map = new HashMap<>(3);
      map.put("scene", s);
      map.put("result", s1);
      channel.invokeMethod("onShowSuccess", map);
      TGSDKUtil.warning("Flutter   onShowSuccess: ");
    }

    @Override
    public void onShowFailed(String s, String s1, String s2) {
      Map<String, String> map = new HashMap<>(3);
      map.put("scene", s);
      map.put("result", s1);
      map.put("error", s2);
      channel.invokeMethod("onShowFailed", map);
    }

    @Override
    public void onADClick(String s, String s1) {
      Map<String, String> map = new HashMap<>(3);
      map.put("scene", s);
      map.put("result", s1);
      channel.invokeMethod("onADClick", map);
    }

    @Override
    public void onADClose(String s, String s1, boolean b) {
      Map<String, Object> map = new HashMap<>(3);
      map.put("scene", s);
      map.put("result", s1);
      map.put("couldReward", b);
      channel.invokeMethod("onADClose", map);
    }
  };

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
      Activity activity = registrar.activity();
      mActivity = new WeakReference<>(activity);
      channel = new MethodChannel(registrar.messenger(), "ftgsdk");
      channel.setMethodCallHandler(new FtgsdkPlugin());
  }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "preload":
                if (mActivity.get() == null) {
                    result.error("", "", "");
                    Map<String, String> map = new HashMap<>(3);
                    map.put("result", "Activity is null");
                    channel.invokeMethod("preloadFailed", map);
                    break;
                }
                TGSDK.initialize(mActivity.get(),
                        call.<String>argument("appid"),
                        call.<String>argument("channelId"),
                        null);
                TGSDK.preloadAd(mActivity.get(), new ITGPreloadListener() {
                    @Override
                    public void onPreloadSuccess(String s) {
                        Map<String, String> map = new HashMap<>(3);
                        map.put("result", s);
                        channel.invokeMethod("preloadSuccess", map);
                    }

                    @Override
                    public void onPreloadFailed(String s, String s1) {
                        Map<String, String> map = new HashMap<>(3);
                        map.put("result", s1);
                        channel.invokeMethod("preloadFailed", map);
                    }

                    @Override
                    public void onCPADLoaded(String s) {

                    }

                    @Override
                    public void onVideoADLoaded(String s) {

                    }

                    @Override
                    public void onAwardVideoLoaded(String s) {
                        Map<String, String> map = new HashMap<>(3);
                        map.put("result", s);
                        channel.invokeMethod("awardVideoLoaded", map);
                    }

                    @Override
                    public void onInterstitialLoaded(String s) {
                        Map<String, String> map = new HashMap<>(3);
                        map.put("result", s);
                        channel.invokeMethod("interstitialLoaded", map);
                    }

                    @Override
                    public void onInterstitialVideoLoaded(String s) {
                        Map<String, String> map = new HashMap<>(3);
                        map.put("result", s);
                        channel.invokeMethod("interstitialVideoLoaded", map);
                    }
                });
                TGSDK.setADListener(adListener);
                result.success(true);
                break;
            case "couldShow":
                result.success(mActivity.get() != null && TGSDK.couldShowAd(call.<String>argument("scene")));
                break;
            case "showAd":
                if (mActivity.get() == null) {
                    result.error("", "", "");
                    Map<String, String> map = new HashMap<>(3);
                    map.put("scene", call.<String>argument("scene"));
                    map.put("result", "");
                    map.put("error", "Activity is null");
                    channel.invokeMethod("onShowFailed", map);
                    break;
                }

                TGSDK.showAd(mActivity.get(), call.<String>argument("scene"));
                result.success("");
                break;
            case "showTestView":
                if (mActivity.get() == null) {
                    result.error("", "", "");
                    Map<String, String> map = new HashMap<>(3);
                    map.put("scene", call.<String>argument("scene"));
                    map.put("result", "");
                    map.put("error", "Activity is null");
                    channel.invokeMethod("onShowFailed", map);
                    break;
                }
                TGSDK.showTestView(mActivity.get(), call.<String>argument("scene"));
                result.success("");
                break;
            case "closeBanner":
                if (mActivity.get() == null) {
                    result.error("", "", "");
                    Map<String, String> map = new HashMap<>(3);
                    map.put("scene", call.<String>argument("scene"));
                    map.put("result", "");
                    map.put("error", "Activity is null");
                    channel.invokeMethod("onShowFailed", map);
                    break;
                }
                TGSDK.closeBanner(mActivity.get(), call.<String>argument("scene"));
                result.success("");
                break;
            case "setBannerConfig":
                TGBannerType bannerType = TGBannerType.TGBannerNormal;
                String type = call.<String>argument("type");
                if ("TGBannerLarge".equalsIgnoreCase(type)) {
                    bannerType = TGBannerType.TGBannerLarge;
                } else if ("TGBannerMediumRectangle".equalsIgnoreCase(type)) {
                    bannerType = TGBannerType.TGBannerMediumRectangle;
                }
                TGSDK.setBannerConfig(call.<String>argument("scene"),
                        bannerType,
                        call.<Integer>argument("x"),
                        call.<Integer>argument("y"),
                        call.<Integer>argument("width"),
                        call.<Integer>argument("height"),
                        call.<Integer>argument("interval"));
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
