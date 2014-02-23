#import <Cocoa/Cocoa.h>

@class Player;
@class MasterMind;

@interface BTPlayerAvatar : NSObject 
{
    IBOutlet NSTableView *hand;
    IBOutlet NSTextField *name;
	IBOutlet NSTextField *callout;
	
	Player* player;
}

- (id)init;
- (void)setPlayer:(Player*) aPlayer;
- (void)setMind:(MasterMind*) aMind;

//Avatar Methods
- (void)handChanged;

- (void)callTrumpOpen:(BOOL) forced;
- (void)callTrumpClose:(id) sender;
- (void)playTrickOpen;
- (void)playTrickClose;

- (void)say:(NSString*) gibberish;

//Table Datasource Methods
- (int)numberOfRowsInTableView:(NSTableView *)aTableView;
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex;

- (void)dealloc;

@end
