//
//  Global.swift
//  E_Learning
//
//  Created by sin on 2021/10/9.
//

import UIKit

/** 系统版本 */
let SYSTEM_VERSION = UIDevice.current.systemVersion

/** 屏幕尺寸 */
let SCREEN_SIZE = UIScreen.main.bounds.size

/** 屏幕高度 */
let SCREEN_HEIGHT = UIScreen.main.bounds.height

/** 屏幕宽度 */
let SCREEN_WIDTH = UIScreen.main.bounds.width

/** 屏幕比例 */
let SCREEN_SCALE = UIScreen.main.scale

/** 导航条 + 状态栏高度 */
let NAVIGATIONBAR_N_STATUSBAR_HEIGHT = 64.0

/** 导航条 + 状态栏动态高度 */
let NaviHeight: CGFloat = (STATUSBAR_HEIGHT > 20) ? 94 : 64

let TabbarHeightMore: CGFloat = (STATUSBAR_HEIGHT > 20) ? 34 : 0

let NAVI_SIZE: CGSize = CGSize(width: SCREEN_WIDTH, height: NaviHeight)

/** 状态栏高度 */
let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height

/** AppDelegate */
let ELAppDelegate = ((UIApplication.shared.delegate) as! AppDelegate)
/** window对象 */
let ELWindow = ((UIApplication.shared.delegate) as! AppDelegate).window

/** 导航条高度 */
let NAVIGATIONBAR_HEIGHT = 44.0

/** TabBar高度 */
let TABBAR_HEIGHT = 49.0
let TABBAR_HEIGHT_X = 83.0

/** 宽度比例 */
let widthScale : CGFloat =  CGFloat(SCREEN_WIDTH / 375)
/** 自动计算屏幕宽度尺寸 */
func scaleNum(_ w:CGFloat) -> CGFloat {
    let num = w / 375 * SCREEN_WIDTH
    return num
}

/** 文本提示 */
let NETWORK_ANOMALIES = "网络异常，请重新请求"

/** 课程详情提示 */
let INTRO_START_BUTTON = "Start"
let PROGREE_VIEW_TITLE = "Learning Progress"
let PROGREE_STATUS_TITLE = "Status: Started"

/** 课程信息提示 */
let COURSE_INFO_TITLE = "Curator / Contacts"

/** tabbar标题 */
let HOME_TABBAR_NAME = "Home"
let COURSE_TABBAR_NAME = "Course"
let MY_TABBAR_NAME = "My"

/** 网络环境 */
#if DEBUG
    let DOMAIN_BASE_URL = "xxx"
#else
    let DOMAIN_BASE_URL = "xxx"
#endif

/** H5环境 */
#if DEBUG
    let SERVICE_BASE_URL = "xxx"
#else
    let SERVICE_BASE_URL = ""
#endif


/** 接口名 */
