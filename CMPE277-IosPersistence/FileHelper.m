//
//  FileHelper.m
//  CMPE277-IosPersistence
//
//  Created by Jon Guan on 5/2/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import "FileHelper.h"

@implementation FileHelper

+ (NSString *)docsDir
{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];
}

+ (NSString *)pathForFileName:(NSString *)filename
{
    return [[FileHelper docsDir] stringByAppendingPathComponent:filename];
}

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
