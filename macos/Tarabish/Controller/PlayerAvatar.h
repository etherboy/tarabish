#import <Cocoa/Cocoa.h>
#import "FJVAvatar.h"

@class FJVPlayer;
@class FJVMasterMind;

@interface FJVPlayerAvatar : NSObject  <FJVAvatar>
{
    IBOutlet NSTableView *hand;
    IBOutlet NSTextField *name;
	IBOutlet NSTextField *callout;
	
	FJVPlayer* player;
}

- (id)init;
- (void)setPlayer:(FJVPlayer*) aPlayer;
- (void)setMind:(FJVMasterMind*) aMind;

//Avatar Methods
- (void)handChanged;

- (void)callTrumpOpen:(BOOL) forced;
- (void)callTrumpClose:(id) sender;
- (void)playTrickOpen;
- (void)playTrickClose;

- (void)say:(NSString*) gibberish;

//Table Datasource Methods
- (NSUInteger)numberOfRowsInTableView:(NSTableView *)aTableView;
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex;

@end
