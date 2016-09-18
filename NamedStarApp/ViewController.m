//
//  ViewController.m
//  StarSpaceApps
//
//  Created by Curtis Mason on 9/17/16.
//  Copyright © 2016 Curtis Mason. All rights reserved.
//
//2248 stars
//http://www.stellar-database.com/Scripts/search_star.exe?ID=224800
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//ascension and declination
-(NSString*)GetCoordinates:(const char*)character{
    int count = -1;
    int begin = 0;
    int etc = 0;
    int end = 0;
    int special=1;
    bool found = true;
    bool locate = false;
    while(found){
        if((character[count]=='<')&&(character[count+1]=='B')&&(character[count+7]=='C')&&(character[count+8]=='e')){
            locate = true;
            begin = count+48;
            count= count+47;
        }
        while(locate==true){
            count++;
            if(character[count]=='<'&&character[count+1]=='B'){
                locate = false;
                found = false;
                end = count-1;
            }
        }
        count++;
    }
    int interval = (end-begin)+1;
   // NSLog(@"%d", interval);
    char code[interval];
    while((end)>=(begin)){
        code[etc] = character[begin];
        begin++;
        etc++;
    }
    NSString *s = [NSString stringWithFormat:@"%s", code];
    return s;
}
-(NSString*) GetName: (const char*) character{
    int count = -1;
    int begin = 0;
    int etc = 0;
    int end = 0;
    int special=1;
    bool found = true;
    bool locate = false;
    while(found){
        if((character[count]=='H')&&(character[count+1]=='1')&&(character[count+2]=='>')&&(character[count-1]=='<')){
            locate = true;
            begin = count+3;
            count = count+2;
        }
        while(locate==true){
            count++;
            if(character[count]=='<'&&character[count+1]=='/'&&character[count+2]=='H'){
                locate = false;
                found = false;
                end = count-1;
            }
        }
        count++;
    }
    int interval = (end-begin)+1;
    //NSLog(@"%d", interval);
    char code[interval];
    while((end)>=(begin)){
        code[etc] = character[begin];
        begin++;
        etc++;
    }
    NSString *s = [NSString stringWithFormat:@"%s", code];
    return s;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    int queryValue = 100;
    while (queryValue<=224800) {
        
    NSError *error = nil;
    NSString *urlString = [NSString stringWithFormat:@"%@%d", @"http://www.stellar-database.com/Scripts/search_star.exe?ID=", queryValue];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    NSString *webSource = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
   // NSLog(@"README:");
   // NSLog(webSource);
    const char *c = [webSource UTF8String];
    NSString* Coordinates = [self GetCoordinates:c];
//    NSLog(@"Coordinates:");
//    NSLog([self GetCoordinates:c]);
//    NSLog(@"Name:");
//    NSLog([self GetName:c]);
        
    NSString* Main = [NSString stringWithFormat:@"Name: %@\nCoordinates: %@", [self GetName:c], [self GetCoordinates:c]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/ScoutingAppsDatabase/Stars"];
    NSLog(dataPath);
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&error];
    
    double unixTime = [[NSDate date] timeIntervalSince1970];
    NSString *UnixTime = [NSString stringWithFormat:@"%f", unixTime];
    
    documentsDirectory = [NSString stringWithFormat:@"%@/ScoutingAppsDatabase/Stars", documentsDirectory];
    
    
    BOOL succeed = [Main writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [self GetName:c]]] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    //NSLog(documentsDirectory);
        queryValue=queryValue+100;
    }
    NSLog(@"Done");
}
-(IBAction)Pushing:(id)sender{
    //https://api.scriptrapps.io/SpaceApps/Database/Stars
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

@end
