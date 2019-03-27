//
//  ViewController.m
//  LayerGeometry
//
//  Created by 袁伟森 on 2019/3/27.
//  Copyright © 2019 袁伟森. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *shi;
@property (weak, nonatomic) IBOutlet UIImageView *fen;
@property (weak, nonatomic) IBOutlet UIImageView *miao;
@property (nonatomic, weak) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (nonatomic, strong) CALayer *blueLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self tapCALayer];
    

}
//CALayer点击事件
-(void)tapCALayer{
    self.blueLayer = [CALayer layer];
    
    self.blueLayer.frame = CGRectMake(40, 20, 100, 100);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.blueView.layer addSublayer:self.blueLayer];
    self.blueView.layer.masksToBounds = YES;
}
//使用containsPoint判断被点击的图层
//使用hitTest判断被点击的图层
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //使用containsPoint判断被点击的图层
    /*
    //获取相对于主视图的触摸位置
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //将点转换为白色图层的坐标
    point = [self.blueView.layer convertPoint:point toLayer:self.blueLayer];
    
    if ([self.blueView.layer containsPoint:point]) {
        //使用containsPoint获取图层:
        point = [self.blueLayer convertPoint:point fromLayer:self.blueView.layer];
        if ([self.blueLayer containsPoint:point]) {
            [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"Inside White Layer"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }else{
        
    }
    */
    //使用hitTest判断被点击的图层

    CGPoint point = [[touches anyObject] locationInView:self.view];
    CALayer *layer = [self.blueView.layer hitTest:point];
    
    if (layer == self.blueLayer) {
        [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else if (layer == self.blueView.layer) {
        [[[UIAlertView alloc] initWithTitle:@"Inside White Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    
}
//反转几何结构
-(void)reverse{
    //反转几何结构
    //UIView只存在在二维坐标系中
    //CALyer存在三维坐标系中
    //zPosition、anchorPointZ 都是在Z轴上的作用
    //除了做变换之外，zPosition最实用的功能就是改变图层的显示顺序了。
    self.greenView.layer.zPosition = 1.0f;
    
}


//CALayer的anchorPoint属性（锚点）
- (void)anchorPoint{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    //初始化时钟位置
    [self tick];
    //锚点 默认为图层的中心点（0.5，0.5）
    //改变锚点也可以改变frame
    self.shi.layer.anchorPoint = CGPointMake(0.5f, 0.85f);
    self.fen.layer.anchorPoint = CGPointMake(0.5f, 0.85f);
    self.miao.layer.anchorPoint = CGPointMake(0.5f, 0.85f);
}
- (void)tick
{
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    //calculate hour hand angle //calculate minute hand angle
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    //rotate hands
    self.shi.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.fen.transform = CGAffineTransformMakeRotation(minsAngle);
    self.miao.transform = CGAffineTransformMakeRotation(secsAngle);
}

@end
