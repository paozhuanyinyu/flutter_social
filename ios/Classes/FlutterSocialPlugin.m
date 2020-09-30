#import "FlutterSocialPlugin.h"

@implementation FlutterSocialPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"kaige.com/social"
            binaryMessenger:[registrar messenger]];
  FlutterSocialPlugin* instance = [[FlutterSocialPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if([@"goToQQChat" isEqualToString:call.method]){
      [self goToQQChat:call result:result];
  }else if([@"goToQQGroup" isEqualToString:call.method]){
      [self goToQQGroup:call result:result];
  }else if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)goToQQChat:(FlutterMethodCall*)call result:(FlutterResult)result{
    NSString* qqNum = call.arguments[@"qqNum"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNum]];
            
    if([[UIApplication sharedApplication] canOpenURL:url]){
      [[UIApplication sharedApplication] openURL:url];
        result([NSNumber numberWithBool:YES]);
    } else {
      NSLog(@"不能调起QQ");
        result([NSNumber numberWithBool:NO]);
    }
}
- (void)goToQQGroup:(FlutterMethodCall*)call result:(FlutterResult)result{
    NSString* qqGroupNum = call.arguments[@"qqGroupNum"];
    NSString* qqGroupKey = call.arguments[@"qqGroupKey"];
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external&jump_from=webapi", qqGroupNum,qqGroupKey];
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
        result([NSNumber numberWithBool:YES]);
    }
    else result([NSNumber numberWithBool:NO]);
}
@end
