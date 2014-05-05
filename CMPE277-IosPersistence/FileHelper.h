//
//  FileHelper.h
//  CMPE277-IosPersistence
//
//  Created by Jon Guan on 5/2/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

+ (NSURL *)applicationDocumentsDirectory;

+ (NSString *)docsDir;

+ (NSString *)pathForFileName:(NSString *)filename;

@end
