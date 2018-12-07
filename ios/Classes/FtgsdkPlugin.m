#import "FtgsdkPlugin.h"
#import "TGSDK.h"

@interface FtgsdkPlugin () <TGPreloadADDelegate, TGADDelegate>

@end

@implementation FtgsdkPlugin

FlutterMethodChannel *channel;

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    channel = [FlutterMethodChannel
            methodChannelWithName:@"ftgsdk"
                  binaryMessenger:[registrar messenger]];
    FtgsdkPlugin *instance = [[FtgsdkPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"preload" isEqualToString:call.method]) {
        [TGSDK initialize:@"Your application ID from yomob"
                 callback:nil];
        [TGSDK preloadAd:self];
        result(@"ios" "");
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)onPreloadSuccess:(NSString *_Nullable)result {
}

- (void)onPreloadFailed:(NSString *_Nullable)result WithError:(NSString *_Nullable)error {
}

- (void)onVideoADLoaded:(NSString *_Nonnull)result {
}

- (void)onCPADLoaded:(NSString *_Nonnull)result {
}

// ------------------------ TGADDelegate ------------------------
- (void)onShowSuccess:(NSString *)result {
}

- (void)onShowFailed:(NSString *)result WithError:(NSString *)error {
}

- (void)onADComplete:(NSString *)result {
}

- (void)onADClick:(NSString *)result {
}

- (void)onADClose:(NSString *)result {
}
@end

