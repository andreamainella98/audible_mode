#import "AudibleModePlugin.h"

#if __has_include(<audible_mode/audible_mode-Swift.h>)
#import <audible_mode/audible_mode-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "audible_mode-Swift.h"

#endif

@implementation AudibleModePlugin
+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    [SwiftAudibleModePlugin registerWithRegistrar:registrar];
}
@end
