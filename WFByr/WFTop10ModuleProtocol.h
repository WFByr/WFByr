//
//  WFTop10ModuleProtocol.h
//  WFByr
//
//  Created by Andy on 2017/5/25.
//  Copyright © 2017年 andy. All rights reserved.
//

#ifndef WFTop10ModuleProtocol_h
#define WFTop10ModuleProtocol_h

@class UIViewController;

@protocol WFTop10Module <NSObject>

@required
- (UIViewController*) rootVC;

@end
#endif /* WFTop10ModuleProtocol_h */
