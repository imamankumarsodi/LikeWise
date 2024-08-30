//
//  AppMacros.swift
//  HeroAppDesign
//
//  Created by cst on 24/12/19.
//  Copyright © 2019 cst. All rights reserved.
//

import Foundation
import UIKit

let NOTIFICATION_CENTER = NotificationCenter.default
let FILE_MANAGER = FileManager.default
let MAIN_BUNDLE = Bundle.main
let MAIN_THREAD = Thread.main
let MAIN_SCREEN = UIScreen.main
let MAIN_SCREEN_WIDTH = UIScreen.main.bounds.width
let MAIN_SCREEN_HEIGHT = UIScreen.main.bounds.height
let USER_DEFAULTS = UserDefaults.standard
let APPLICATION = UIApplication.shared
let CURRENT_DEVICE = UIDevice.current
let MAIN_RUN_LOOP = RunLoop.main
let GENERAL_PASTEBOARD = UIPasteboard.general
let CURRENT_LANGUAGE = NSLocale.current.languageCode
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
var newProfile = Bool()
let STATUS_BAR_DEFAULT_HEIGHT = 20
let NAVIGATION_BAR_DEFAULT_HEIGHT = 44
let TOOLBAR_DEFAULT_HEIGHT = 44
let TABBAR_DEFAULT_HEIGHT = 49
let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "

//TODO: Network

let kNoInterNet = "No internet"
let NETWORK_ACTIVITY = APPLICATION.isNetworkActivityIndicatorVisible

//TODO: Application informations

let APP_BUNDLE_NAME = MAIN_BUNDLE.infoDictionary?[kCFBundleNameKey as String]
let APP_NAME = "Like Wise"
let APP_VERSION = MAIN_BUNDLE.object(forInfoDictionaryKey: "CFBundleVersion")
let IN_SIMULATOR = (TARGET_IPHONE_SIMULATOR != 0)
let IS_NEW_CODE = false
