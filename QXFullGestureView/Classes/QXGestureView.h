//
//  BaseGestureView.h
//  IntelligentLamps
//
//  Created by lqx on 15/9/27.
//  Copyright © 2015年 shanggu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(UITapGestureRecognizer *tap);
typedef void(^lPressBlock)(UILongPressGestureRecognizer *Lpress);
typedef void(^SwipeBlock)(UISwipeGestureRecognizer *swipe);
typedef void(^PanBlock)(UIPanGestureRecognizer *pan);
typedef void(^PinchBlock)(UIPinchGestureRecognizer *pinch);
typedef void(^RotationBlock)(UIRotationGestureRecognizer *rotation);

@interface QXGestureView : UIView<UIGestureRecognizerDelegate>
//block
@property (copy, nonatomic) TapBlock tapBlock;
@property (copy, nonatomic) lPressBlock lPressBlock;
@property (copy, nonatomic) SwipeBlock swipeBlock;
@property (copy, nonatomic) PanBlock panBlock;
@property (copy, nonatomic) PinchBlock pinchBlock;
@property (copy, nonatomic) RotationBlock rotationBlock;
//GestureRecognizer
@property (nonatomic, strong)UITapGestureRecognizer *singleTap;
//特殊操作（改变frame）-是否执行flag
@property (nonatomic, assign) BOOL isMove;
@property (nonatomic, assign) BOOL isRotation;
@property (nonatomic, assign) BOOL isPinch;

//move
- (void)panOperationClick:(UIPanGestureRecognizer *)pan;
@end
