//
//  IMManager.h
//  imsdk
//
//  Created by harvy on 2022/10/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol IMSDKListener <NSObject>

- (void)onLogined;

@end


@interface IMManager : NSObject

+ (instancetype)shareManager;

- (void)addListener:(id<IMSDKListener>)listener;
- (void)removeListener:(id<IMSDKListener>)listener;

- (void)login;

@end

NS_ASSUME_NONNULL_END
