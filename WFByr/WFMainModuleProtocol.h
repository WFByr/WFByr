//
//  WFMainModuleProtocol.h
//  WFByr
//
//  Created by Andy on 2017/6/28.
//  Copyright © 2017年 andy. All rights reserved.
//

#ifndef WFMainModuleProtocol_h
#define WFMainModuleProtocol_h

@protocol WFMainModule <NSObject>

@required
- (UIViewController*)rootVC;

@end

#endif /* WFMainModuleProtocol_h */
