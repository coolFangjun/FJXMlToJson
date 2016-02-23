//
//  FJXmlToJSon.m
//  ChatDemo
//
//  Created by 小宸宸Dad on 16/2/23.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "FJXmlToJSon.h"

@interface FJXmlToJSon ()<NSXMLParserDelegate>{

    NSMutableArray          *valueArray;
    NSMutableArray          *keyArray;
    NSMutableString         *currentValue;
    NSString                *xmlFileName;



}

/**
 *  返回json数据格式
 */
@property (weak,nonatomic)void(^resultDic)(id resultDic);

/**
 *  返回data文件
 */

@property (weak,nonatomic)void(^resultDataPath)(NSString *dataPathStr);


@end

@implementation FJXmlToJSon


- (void)xmlToJson:(NSString *)xmlPathStr  fileName:(NSString *)fileName resultDic:(void(^)(NSDictionary *resultDic))resultDic resultDataPath:(void(^)(NSString *pathStr))resultDataPath{

    valueArray = [NSMutableArray array];
    keyArray   = [NSMutableArray array];
    currentValue = 0;
    xmlFileName = fileName;
    self.resultDic = resultDic;
    self.resultDataPath = resultDataPath;
    NSString *xmlContent=[[NSString alloc] initWithContentsOfFile:xmlPathStr encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser *xmlParse = [[NSXMLParser alloc]initWithData:[xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
    xmlParse.delegate = self;
    [xmlParse parse];
    


}




- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"%@",attributeDict);
    NSArray *temp = [attributeDict allValues];
    
    if (temp.count != 0) {
        [keyArray addObject:[temp lastObject]];
    }
    
    if (currentValue != nil) {
        
        NSLog(@"%@",currentValue);
        
        if (![currentValue isEqualToString:@"\n\n    "]) {
            
            [valueArray addObject:currentValue];
        }
        currentValue = nil;
    }
    currentValue = [[NSMutableString alloc]init];
    
    
}





- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    [currentValue appendString:string];
    NSLog(@"%@",currentValue);
}



- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    NSLog(@"%@",valueArray);
    if (currentValue) {
        
        [valueArray addObject:currentValue];
    }
    
    NSLog(@"%@",keyArray);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < keyArray.count; i ++) {
        
        [dic setValue:valueArray[i] forKey:keyArray[i]];
        
    }
    NSLog(@"%@",dic);
    self.resultDic([dic mutableCopy]);
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",xmlFileName]];
    
    [data writeToFile:path atomically:YES];
    NSLog(@"%@",path);
    self.resultDataPath(path);
    
}









@end
