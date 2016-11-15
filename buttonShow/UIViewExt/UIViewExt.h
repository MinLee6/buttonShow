/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
//方便获取任何一个控件的frame属性
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
/** 位置x,y */
@property CGPoint origin;
/** 宽高width,height */
@property CGSize size;

/** 左下角的x,y */
@property (readonly) CGPoint bottomLeft;
/** 右下角的x,y */
@property (readonly) CGPoint bottomRight;
/** 右上角x,y */
@property (readonly) CGPoint topRight;

/** 高度 */
@property CGFloat height;
/** 宽度 */
@property CGFloat width;

/** x */
@property CGFloat top;
/** y */
@property CGFloat left;
/** 下边的位置：y+height */
@property CGFloat bottom;
/** 右边的位置：x+width */
@property CGFloat right;
/** 移动x,y点 */
- (void) moveBy: (CGPoint) delta;
/** 缩放比例 */
- (void) scaleBy: (CGFloat) scaleFactor;
/** 等比缩放 */
- (void) fitInSize: (CGSize) aSize;
@end