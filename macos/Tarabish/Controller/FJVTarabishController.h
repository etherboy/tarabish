/* TarabishController */

#import <Cocoa/Cocoa.h>
#import "FJVTarabishMatch.h"

@interface FJVTarabishController : NSObject
{
	//IBOutlet FJVPlayerAvatar* pa1;
	//IBOutlet FJVPlayerAvatar* pa2;
	//IBOutlet FJVPlayerAvatar* pa3;
	//IBOutlet FJVPlayerAvatar* pa4;
	
	IBOutlet NSTextField *trump;
	
	FJVTarabishMatch* game;
}

- (id)init;
- (void)awakeFromNib;
- (IBAction)deal:(id)sender;

@end
