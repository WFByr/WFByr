//
//  WFSectionModuleProtocol.h
//  WFByr
//
//  Created by Andy on 2017/6/2.
//  Copyright © 2017年 andy. All rights reserved.
//

#ifndef WFSectionModuleProtocol_h
#define WFSectionModuleProtocol_h

@protocol WFSectionModule <NSObject>

@required
- (UIViewController*) rootVC;

@end
#endif /* WFSectionModuleProtocol_h */
