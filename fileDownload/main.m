//
//  main.m
//  fileDownload
//
//  Created by Vijith Venkatesh on 4/7/14.
//  Copyright (c) 2014 Vijith Venkatesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QnA.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Hello, World!");
        NSString *stringURL = @"https://dl.dropboxusercontent.com/u/102619389/morning.txt";
        NSURL  *url = [NSURL URLWithString:stringURL];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
            NSArray   *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString  *documentsDirectory = [paths objectAtIndex:0];
            
            NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"vijmorning.txt"];
            [urlData writeToFile:filePath atomically:YES];
            
            NSString *fileContents = [NSString stringWithContentsOfFile:filePath usedEncoding:nil error:nil];
            NSArray *lines = [fileContents componentsSeparatedByString:@"\n"];
            NSLog(@"%lu",(unsigned long)lines.count);
            NSMutableArray *set = [[NSMutableArray alloc] init];
            
            
            for (long i=0; i<lines.count; i++) {
                NSArray *catQues = [lines[i] componentsSeparatedByString:@"#"];
                QnA *qna = [[QnA alloc]init];
                if(catQues.count>1){
                    NSLog(@"the count is %ld",catQues.count);
                    qna.category=catQues[0];
                    qna.question=catQues[1];
                    long step=(long)[catQues[2] integerValue];
                    //i++;
                    for (long j=i+1; j<(step+i); j++) {
                        [qna.answers addObject:lines[j]];
                    }
                    i=i+step;
                    NSLog(@"%ld",i);
                    [set addObject:qna];
                    
                }
            }
            
            NSLog(@"%lu",set.count);
            NSLog(@"%@",set);
            
        }
        
        
        
        
        
    }
    return 0;
}

