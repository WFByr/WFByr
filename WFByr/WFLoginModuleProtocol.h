//
//  WFLoginModuleProtocol.h
//  WFByr
//
//  Created by Andy on 2017/5/26.
//  Copyright © 2017年 andy. All rights reserved.
//

#ifndef WFLoginModuleProtocol_h
#define WFLoginModuleProtocol_h


@class UIViewController;

@protocol WFLoginModule <NSObject>

@required
- (UIViewController*) rootVC;

@end

#endif /* WFLoginModuleProtocol_h */
