//
//  MHWDriver.h
//  HyperWitching
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHWDriver : NSObject

+ (instancetype)get;
+ (void)speedup;
+ (NSString *)state;

@property (nonatomic) UIView *rootView;

@end

NS_ASSUME_NONNULL_END
