#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

static NSString *scenariosPath = @"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/Frameworks/CoreLocation.framework/Support/SimulationScenarios";

static void exportScenarioToGPX(NSString *scenarioPath) {
	NSLog(@"-> Exporting scenario %@", scenarioPath);
	
	NSXMLElement *root = (NSXMLElement *)[NSXMLNode elementWithName:@"gpx"];
	NSXMLDocument *xmlDocument = [[NSXMLDocument alloc] initWithRootElement:root];
	[xmlDocument setVersion:@"1.0"];
	[xmlDocument setCharacterEncoding:@"UTF-8"];
	[root addChild:[NSXMLNode commentWithStringValue:[NSString stringWithFormat:@"Created from %@", scenarioPath]]];
	NSXMLElement *trackChild = [[NSXMLElement alloc] initWithName:@"trk"];	
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:scenarioPath];
	for (NSData *locationData in dictionary[@"Locations"]) {
		CLLocation *location = [NSKeyedUnarchiver unarchiveObjectWithData:locationData];
		NSXMLElement *trackPoint = [[NSXMLElement alloc] initWithName:@"trkpt"];
		[trackPoint addAttribute:[NSXMLNode attributeWithName:@"lat" stringValue:@(location.coordinate.latitude).stringValue]];
		[trackPoint addAttribute:[NSXMLNode attributeWithName:@"lon" stringValue:@(location.coordinate.longitude).stringValue]];
		[trackChild addChild:trackPoint];
	}
	[root addChild:trackChild];
	
	NSError *error = nil;
	NSString *currentDirectory = [[NSFileManager defaultManager] currentDirectoryPath];
	NSString *xmlFileName = [[[[NSURL fileURLWithPath:scenarioPath] lastPathComponent] stringByDeletingPathExtension] stringByAppendingPathExtension:@"gpx"];
	NSURL *xmlURL = [NSURL fileURLWithPath:[currentDirectory stringByAppendingPathComponent:xmlFileName]];
	if (!xmlURL) {
		NSLog(@"Can't create an URL from file %@.", xmlURL);
		return;
	}
	NSData *xmlData = [xmlDocument XMLDataWithOptions:NSXMLNodePrettyPrint];
	if (![xmlData writeToFile:xmlFileName atomically:YES]) {
		NSLog(@"Could not write document out...");
		return;
	}
	else {
		NSLog(@"-> Results saved to %@", xmlFileName);
	}
}

int main(int argc, char *argv[]) {	
	@autoreleasepool {
		NSArray<NSString *> *scenarios = @[@"City Bicycle Ride.plist", @"City Run.plist", @"Freeway Drive.plist"];
		
		BOOL isDirectory = YES;
		if (![[NSFileManager defaultManager] fileExistsAtPath:scenariosPath isDirectory:&isDirectory]) {
			NSLog(@"Scenarios path doesn't exist: %@.\nXcode and iOS simulator should be installed.", scenariosPath);
			return -1;
		}
		
		for (NSString *scenario in scenarios) {
			NSString *scenarioPath = [scenariosPath stringByAppendingPathComponent:scenario];
			if (![[NSFileManager defaultManager] fileExistsAtPath:scenarioPath]) {
				NSLog(@"Scenario %@ doesn't exist. Skip.", scenarioPath);
			}
			else {
				exportScenarioToGPX(scenarioPath);
			}
		}
	}
}