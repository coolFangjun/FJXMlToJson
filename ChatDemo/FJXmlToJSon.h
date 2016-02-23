//
//  FJXmlToJSon.h
//  ChatDemo
//
//  Created by 小宸宸Dad on 16/2/23.
//  Copyright © 2016年 fj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJXmlToJSon : NSObject


/**
*   xml转换为JSON
*
*  @param xmlPathStr     xml文件的路径
*  @param fileName       xml文件的文件名(方便进行输出为data文件)
*  @param resultDic      返回json数据
*  @param resultDataPath 返回存盘的data文件
*/

- (void)xmlToJson:(NSString *)xmlPathStr  fileName:(NSString *)fileName resultDic:(void(^)(NSDictionary *resultDic))resultDic resultDataPath:(void(^)(NSString *pathStr))resultDataPath;



@end
