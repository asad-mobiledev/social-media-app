//
//  SocialMediaAppTests.swift
//  SocialMediaAppTests
//
//  Created by Asad Mehmood on 07/10/2025.
//

import Testing
@testable import SocialMediaApp

struct SocialMediaAppTests {
    
    @Test func globalFunc() {
        let appText = AppText.OK
        let expectMetaData = "OK"
        #expect(appText == expectMetaData)
    }
}
