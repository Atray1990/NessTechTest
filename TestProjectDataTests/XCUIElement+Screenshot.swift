//
//  ImageView+Svg.swift
//  TestProjectData
//
//  Created by shashank atray on 15/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import XCTest

extension XCUIElement {
    func sayCheese() -> XCTAttachment {
        let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot())
        fullScreenshotAttachment.lifetime = .keepAlways
        return fullScreenshotAttachment
    }
}
