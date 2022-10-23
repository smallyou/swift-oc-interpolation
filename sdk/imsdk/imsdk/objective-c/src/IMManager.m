//
//  IMManager.m
//  imsdk
//
//  Created by harvy on 2022/10/23.
//

#import "IMManager.h"

@interface IMManager ()

@property (nonatomic, strong) NSHashTable *listeners;

@end

@implementation IMManager

static id _instance = nil;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)addListener:(id<IMSDKListener>)listener {
    // not thread-safe operation
    [self.listeners addObject:listener];
}

- (void)removeListener:(id<IMSDKListener>)listener {
    // not thread-safe operation
    [self.listeners removeObject:listener];
}

- (void)login {
    NSLog(@"log in with objective-c");
    for (id<IMSDKListener> target in self.listeners) {
        if ([target respondsToSelector:@selector(onLogined)]) {
            [target onLogined];
        }
    }
}

- (NSHashTable *)listeners {
    if (_listeners == nil) {
        _listeners = [NSHashTable weakObjectsHashTable];
    }
    return _listeners;
}

@end
