#import "FJVTarabishController.h"

@implementation FJVTarabishController

- (id)init
{
	self = [super init];
	
	if(self!=nil)
	{
		game = [[FJVTarabishMatch alloc] init];
	}
	
	return self;
}

- (void)awakeFromNib
{
	NSArray* players = [game players];
	
	[pa1 setPlayer: [players objectAtIndex: 0]];
	[pa1 setMind: [game masterMind]];
	[pa2 setPlayer: [players objectAtIndex: 1]];
	[pa2 setMind: [game masterMind]];
	[pa3 setPlayer: [players objectAtIndex: 2]];
	[pa3 setMind: [game masterMind]];
	[pa4 setPlayer: [players objectAtIndex: 3]];
	[pa4 setMind: [game masterMind]];

	[[players objectAtIndex: 0] setAvatar: pa1];
	[[players objectAtIndex: 1] setAvatar: pa2];
	[[players objectAtIndex: 2] setAvatar: pa3];
	[[players objectAtIndex: 3] setAvatar: pa4];
}

- (IBAction)deal:(id)sender
{
	[pa1 say: @""];
	[pa2 say: @""];
	[pa3 say: @""];
	[pa4 say: @""];
	
	[game beginHand];
}

@end
