//
//  FJVAvatar.h
//  Tarabish
//
//  Created by Fritz Vander Heide on 2014-03-12.
//  Copyright (c) 2014 AppleTrek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FJVAvatar <NSObject>

//Avatar Methods
- (void)handChanged;

- (void)callTrumpOpen:(BOOL) forced;
- (void)callTrumpClose:(id) sender;
- (void)playTrickOpen;
- (void)playTrickClose;

- (void)say:(NSString*) gibberish;

@end
