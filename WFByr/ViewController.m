//
//  ViewController.m
//  WFByr
//
//  Created by Andy on 2017/5/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "ViewController.h"
#import "YYText.h"
#import "YYWebImage.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet YYLabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
   _label.lineBreakMode = NSLineBreakByWordWrapping;
   
   
    NSMutableAttributedString *str = [NSMutableAttributedString new];
    //[str yy_appendString:@"\nasdf "];
    YYAnimatedImageView *imgView = [[YYAnimatedImageView alloc] initWithImage:[UIImage imageNamed:@"psb.jpg"]];
   
    [imgView setImage:[UIImage imageNamed:@"psb.jpg"]];
    //[imgView yy_setImageWithURL:[NSURL URLWithString:@"http://a1.qpic.cn/psb?/V10jOeIm3nhdMu/ZvDFCfvnpHFVZQ1zoK6H9vn*nF3wOX0HPFOcQHEIUUc!/b/dBcBAAAAAAAA&bo=gAJVAwAAAAARAOM!&rf=viewer_4"] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    NSMutableAttributedString *imgStr = [NSMutableAttributedString yy_attachmentStringWithContent:imgView contentMode:UIViewContentModeCenter attachmentSize:imgView.frame.size alignToFont:[UIFont systemFontOfSize:16] alignment:YYTextVerticalAlignmentCenter];
    
    //[imgStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" asdf"]];
    [str appendAttributedString:imgStr];
    [str yy_appendString:@"asdf"];
   // [str insertAttributedString:imgStr atIndex:0];
    
    //[str yy_appendString:@" \n"];
    _label.attributedText = str;
    _label.numberOfLines = 0;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
