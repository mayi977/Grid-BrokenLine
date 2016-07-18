//
//  CartogramView.m
//  EFamily
//
//  Created by Zilu.Ma on 16/7/12.
//  Copyright © 2016年 VSI. All rights reserved.
//

#import "CartogramView.h"

@implementation CartogramView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat height = rect.size.height - 60;//表格的总高度
    [self drawVerticalLine:height];
    
    [self drawHorizontalOfTemperature:height];
}

//绘制竖线
- (void)drawVerticalLine:(CGFloat)height{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width = (self.bounds.size.width-46)/13;
    CGFloat originY = 8;
    for (int i = 0; i < 14; i ++) {
        [path moveToPoint:CGPointMake(33 + width*i, originY)];
        [path addLineToPoint:CGPointMake(33 + width*i, height+originY)];
    }
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineWidth = 0.5;
    [self.layer addSublayer:layer];
    
    originY = originY + height + 3;
    
    for (int i = 13; i >= 0; i --) {
        if (i % 2 == 0) {
            continue;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(33 + width*i - 30/2, originY, 30, 16)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor clearColor];
        label.text = _dateArr[i];
        label.textColor = [UIColor orangeColor];
        [self addSubview:label];
    }
}

//绘制室温的横线
- (void)drawHorizontalOfTemperature:(CGFloat)height{
    
    CGFloat space = height/5;//横线之间的间距
    UIBezierPath *path = [UIBezierPath bezierPath];
    int temperature = 40;
    for (int i = 0; i < 6; i ++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, space*i, 20, 16)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%d",temperature-10*i];
        label.textColor = [UIColor orangeColor];
        [self addSubview:label];
        
        [path moveToPoint:CGPointMake(33, 8+space*i)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width-13, 8+space*i)];
    }
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineWidth = 0.5;
    [self.layer addSublayer:layer];
    
    [self addExplain:@"卧室" originX:36 color:[UIColor redColor]];
}

- (void)addExplain:(NSString *)string originX:(CGFloat)originX color:(UIColor *)color{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(originX, self.bounds.size.height-30, 40, 18)];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = 2;
    label.backgroundColor = [UIColor clearColor];
    label.text = string;
    label.textColor = color;
    [self addSubview:label];
    
    CALayer *cirile = [CALayer layer];
    cirile.position = CGPointMake(originX+40+10, self.bounds.size.height-21);//30-9
    cirile.bounds = CGRectMake(0, 0, 6, 6);
    cirile.cornerRadius = 3;
    cirile.masksToBounds = YES;
    cirile.backgroundColor = color.CGColor;
    [self.layer addSublayer:cirile];
}


@end
