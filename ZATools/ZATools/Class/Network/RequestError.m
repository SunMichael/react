//
//  RequestError.m
//  ApManagerRefactor
//
//  Created by lmf on 22/2/16.
//  Copyright © 2016 treebear. All rights reserved.
//

#import "RequestError.h"

@implementation RequestError

-(instancetype)initWithCode:(NSInteger)code message:(NSString*)msg {
    self = [super init];
    if (self) {
        self.code = code;
        self.message = msg;
    }
    return self;
}

- (BOOL)isKindOfServer {
    return !(_code == 200 && _code == 201);
}

@end
