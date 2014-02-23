/* TarabishController */

#import <Cocoa/Cocoa.h>
#import "TarabishMatch.h"

@interface TarabishController : NSObject
{
	IBOutlet BTPlayerAvatar* pa1;
	IBOutlet BTPlayerAvatar* pa2;
	IBOutlet BTPlayerAvatar* pa3;
	IBOutlet BTPlayerAvatar* pa4;
	
	IBOutlet NSTextField *trump;
	
	TarabishMatch* game;
}

- (id)init;
- (void)awakeFromNib;
- (IBAction)deal:(id)sender;

- (void)dealloc;

@end
