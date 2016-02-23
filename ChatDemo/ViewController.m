//
//  ViewController.m
//  ChatDemo
//
//  Created by 小宸宸Dad on 15/12/7.
//  Copyright © 2015年 fj. All rights reserved.
//

#import "ViewController.h"
#import "FJXmlToJSon.h"



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FJXmlToJSon *xml = [[FJXmlToJSon alloc]init];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"strings藏" ofType:@"xml"];
    
    [xml xmlToJson:path fileName:@"strings藏" resultDic:^(NSDictionary *resultDic) {
       
        NSLog(@"%@",resultDic);
        
    } resultDataPath:^(NSString *pathStr) {
        
        NSLog(@"%@",pathStr);
    }];
    
    
}



@end
