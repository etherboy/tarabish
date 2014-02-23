#import "PlayerAvatar.h"
#import "Card.h"
#import "Player.h"

@implementation BTPlayerAvatar

- (id)init
{
	self = [super init];
	
	if(self!=nil)
	{
		player = nil;
	}
	
	return self;
}

- (void)setPlayer:(Player*) aPlayer
{
	player = aPlayer;

	[name setStringValue: [player name]];
	[hand reloadData];
}

- (void)setMind:(MasterMind*)aMind
{
}

//Avatar Methods
- (void)handChanged
{
	[hand reloadData];
}

- (void)callTrumpOpen: (BOOL)forced
{
	
}

- (void)callTrumpClose: (id)sender
{
	TCardSuit trump = (TCardSuit)[sender intValue];
	NSString* trumpDesc = trump != NONE ? [Card suitDescription: trump] : @"Pass";
	
	[player callTrumpClose: trump];
	[self say: trumpDesc];
}

- (void)playTrickOpen
{
	
}

- (void)playTrickClose
{
	
}

/*
- (void)playCardOpen
{
	
}

- (void)playCardClose: (const CCard* const) card
{
	player->PlayCardClose(card);
}
*/

- (void)say:(NSString*) gibberish
{
	[callout setStringValue: gibberish];
}

//Table View Methods
- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{	
	int cardCount = 0;
	
	if(player)
	{
		cardCount = [[player hand] count];
	}
	
	return cardCount;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	return [[[player hand] objectAtIndex: rowIndex] description];  
}

- (void)dealloc
{	
	[super dealloc];
}

@end
