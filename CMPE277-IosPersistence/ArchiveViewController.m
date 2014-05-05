//
//  SecondViewController.m
//  CMPE277-IosPersistence
//
//  Created by Jon Guan on 5/2/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import "ArchiveViewController.h"
#import "FileHelper.h"

@interface ArchiveViewController ()

@end

@implementation ArchiveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    


}
- (void)loadFilename
{
    self.filename = @"archive.txt";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveDataDict:(NSDictionary *)dict
{
    [NSKeyedArchiver archiveRootObject:dict toFile:[FileHelper pathForFileName:self.filename]];
}

- (NSDictionary *)dictFromData:(NSData *)savedData
{
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
    return dict;
}

@end
