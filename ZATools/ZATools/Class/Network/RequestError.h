//
//  RequestError.h
//  ApManagerRefactor
//
//  Created by lmf on 22/2/16.
//  Copyright © 2016 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestError : NSObject
@property (nonatomic, copy) NSString* message;
@property (nonatomic) NSInteger code;

-(instancetype)initWithCode:(NSInteger)code message:(NSString*)msg;

- (BOOL) isKindOfServer;
@end
