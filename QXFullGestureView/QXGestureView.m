//
//  BaseGestureView.m
//  IntelligentLamps
//
//  Created by lqx on 15/9/27.
//  Copyright © 2015年 shanggu. All rights reserved.
//

#import "QXGestureView.h"


@interface QXGestureView ()

@property (assign, nonatomic) CGFloat raduius;

@end

@implementation QXGestureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addGesture];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self addGesture];
}
- (void)addGesture{
    [self addTapGesture];
    [self addSwipeGesture];
    [self addPanGesture];
    [self addLongPressGesture];
    [self addPinchGesture];
    [self addRotationGesture];
}
/**
 添加点击手势
 */
- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self addGestureRecognizer:tap];
    self.singleTap = tap;
}
- (void)tapClick:(UITapGestureRecognizer *)tap {
    if (self.tapBlock) {
        self.tapBlock(tap);
    }
}

//添加轻扫屏幕手势
- (void)addSwipeGesture {
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeClick:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeClick:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeClick:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeClick:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDown];
    
}
- (void)swipeClick:(UISwipeGestureRecognizer *)swipe {
    if (self.swipeBlock) {
        self.swipeBlock(swipe);
    }
}


//添加长按手势
- (void)addLongPressGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer  alloc] initWithTarget:self action:@selector(longPressClick:)];
    //表示用几个手指触屏，默认为1个手指
    longPress.numberOfTouchesRequired = 1;
    //设置最短长按时间，单位为秒，默认值是0.5
    longPress.minimumPressDuration = 1;
    //表示手势识别期间所允许的手势可移动的范围，默认10
    longPress.allowableMovement = 10;
    [self addGestureRecognizer:longPress];
}

- (void)longPressClick:(UILongPressGestureRecognizer *)longPress{
    if (self.lPressBlock) {
        self.lPressBlock(longPress);
    }
}

//添加平移手势
- (void)addPanGesture {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panClick:)];
    [self addGestureRecognizer:pan];
    
}
- (void)panClick:(UIPanGestureRecognizer *)pan {
    if (self.panBlock) {
        self.panBlock(pan);
    }
    if (_isMove) {
        [self panOperationClick:pan];
    }
    
}

//添加缩放手势
- (void)addPinchGesture {
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchClick:)];
    [self addGestureRecognizer:pinch];
    
}
- (void)pinchClick:(UIPinchGestureRecognizer *)pinch {
    if (self.pinchBlock) {
        self.pinchBlock(pinch);
    }
    if (_isPinch) {
        [self pinchOperationClick:pinch];
    }
    
}

//添加旋转手势
- (void)addRotationGesture {
    //旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationClick:)];
    [self addGestureRecognizer:rotation];
    
}
- (void)rotationClick:(UIRotationGestureRecognizer *)rotation {
    if (self.rotationBlock) {
        self.rotationBlock(rotation);
    }
    if (_isRotation) {
        [self rotationOperationClick:rotation];
        
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
#pragma mark============ 手势范例 ====================

//点击回调
- (void)tapViewClick:(UITapGestureRecognizer *)tap {
    
}
//扫动回调
- (void)swipeViewClick:(UISwipeGestureRecognizer *)swipe {
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"向上扫动");
            break;
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"向下扫动");
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"向左扫动");
            break;
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"向右扫动");
            break;
        default:
            NSLog(@"不明扫动");
            break;
    }
    
}
//长按回调
- (void)longPressViewClick:(UILongPressGestureRecognizer *)longPress {
    
}
//平移回调
- (void)panOperationClick:(UIPanGestureRecognizer *)pan {
    //通过pan手势，能获取到pan.view在self.view上的偏移量
    CGPoint point = [pan translationInView:pan.view];
    //改变中心坐标（原来的中心点+偏移量=当前的中心点）
    pan.view.center = CGPointMake(pan.view.center.x+point.x, pan.view.center.y+point.y);
    //每次调用之后，需要重置手势的偏移量，否则平移手势会自动累加偏移量
    //CGPointZero《==》CGPointMake(0,0);
    [pan setTranslation:CGPointZero inView:pan.view];
    
}
//缩放回调
- (void)pinchOperationClick:(UIPinchGestureRecognizer *)pinch {
    //固定写法
    pinch.view.transform =  CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    //重置缩放系数（否则缩放系数默认是累加）
    pinch.scale = 1.0;
    
}
//旋转回调
-(void)rotationOperationClick:(UIRotationGestureRecognizer *)rotation {
    //rotation.rotation 旋转的角度
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform , rotation.rotation);
    //重置角度
    rotation.rotation = 0;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//}

@end
