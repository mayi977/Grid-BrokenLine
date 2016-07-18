//
//  ViewController.m
//  BrokenLine
//
//  Created by Zilu.Ma on 16/7/18.
//  Copyright © 2016年 Zilu.Ma. All rights reserved.
//

#import "ViewController.h"
#import "CartogramView.h"

@interface ViewController ()

{
    CartogramView *_temperatureView;//表格试图
    CALayer *_tempLayer;//数据展示的折线图层
    NSMutableArray *_dateArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd"];
    NSDate *date = [NSDate date];
    _dateArr = [[NSMutableArray alloc] init];
    for (int i = 13; i >= 0; i --) {
        NSDate *newDate = [date dateByAddingTimeInterval:-60*60*24*i];
        NSString *dateStr = [formatter stringFromDate:newDate];
        [_dateArr addObject:dateStr];
    }
    
    _temperatureView = [[CartogramView alloc] init];
    _temperatureView.frame = CGRectMake(0, 70, self.view.bounds.size.width, self.view.bounds.size.height-100);
    _temperatureView.monitorType = 0;
    _temperatureView.dateArr = _dateArr;
    _temperatureView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_temperatureView];
    
    [self drawBrokenLine];
}

- (void)drawBrokenLine{
    
    NSArray *numberArr = @[@-10,@0,@10,@20,@30,@40,@20,@30,@0,@30,@40,@-10,@20,@0,];
    
    CGFloat originY = 8;
    CGFloat originX = 33;//第一条竖线的横坐标
    CGFloat height = _temperatureView.bounds.size.height-60;//表格的总高度
    CGFloat width = (self.view.bounds.size.width-46)/13;//两竖线之间的间距
    CGFloat space = height/50;//每°代表的高度
    UIColor *roomColor = [UIColor redColor];
    
    _tempLayer = [CALayer layer];
    _tempLayer.position = CGPointMake(_temperatureView.bounds.size.width/2, _temperatureView.bounds.size.height/2);
    _tempLayer.bounds = CGRectMake(0, 0,_temperatureView.bounds.size.width, _temperatureView.bounds.size.height);
    _tempLayer.backgroundColor = [UIColor clearColor].CGColor;
    [_temperatureView.layer addSublayer:_tempLayer];
    
    UIBezierPath *roomPath= [UIBezierPath bezierPath];
    CAShapeLayer *roomLine = [[CAShapeLayer alloc] init];
    roomLine.strokeColor = roomColor.CGColor;
    roomLine.fillColor = [UIColor clearColor].CGColor;
    roomLine.lineWidth = 0.5;
    [_tempLayer addSublayer:roomLine];
    
    BOOL firstOfRoom = YES;
    for (int i = 0; i < 14; i ++) {
        int value = [numberArr[i] intValue];
        CGPoint roomCenter = CGPointMake(originX + width * i, originY+height-space*(value+10));
        [self drawCirile:roomCenter layer:_tempLayer color:roomColor];
        if (firstOfRoom) {
            [roomPath moveToPoint:roomCenter];
            firstOfRoom = NO;
        }else{
            [roomPath addLineToPoint:roomCenter];
        }

    }
    roomLine.path = roomPath.CGPath;
    
    //折线的绘制动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.duration = 4.0;
    [roomLine addAnimation:animation forKey:nil];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
}

- (void)drawCirile:(CGPoint)center layer:(CALayer *)layer color:(UIColor *)color{
    
    CALayer *roomCirile = [CALayer layer];
    roomCirile.position = center;
    roomCirile.bounds = CGRectMake(0, 0, 6, 6);
    roomCirile.cornerRadius = 3;
    roomCirile.masksToBounds = YES;
    roomCirile.backgroundColor = color.CGColor;
    [layer addSublayer:roomCirile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
