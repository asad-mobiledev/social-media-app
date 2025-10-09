//
//  SocialMediaAppTests.swift
//  SocialMediaAppTests
//
//  Created by Asad Mehmood on 07/10/2025.
//

import Testing
@testable import SocialMediaApp

// Way to declare tags and associate tests with a tag.


struct SocialMediaAppTests {
    
    @Test("Test all text constants", arguments: [
        "OK",
        "Posts"
    ]) func appTexts(text: String) {
        let appText = text
        do {
            try #require(appText == text) // to require something early before proceeding further or fail early.
        } catch {
            print(error.localizedDescription)
        }
            let expectMetaData = text
        #expect(appText == expectMetaData)
    }
    
    @Test
    func testTags() {
        let appText = AppText.OK
        do {
            try #require(appText == "OK") // to require something early before proceeding further or fail early.
        } catch {
            print(error.localizedDescription)
        }
            let expectMetaData = "OK"
        #expect(appText == expectMetaData)
    }
    
//    @Test(.enabled(if: AppText.posts == "Posts"))
//    func textMatching() async throws {
//        <#body#>
//    }
//    
//    @Test(.disabled("Due to unknown crash"))
//    func disabledTest() async throws {
//        <#body#>
//    }
//    
//    @Test(.disabled("Due to unknown crash"), .bug("https://www.example.org/bugs/1234", "Program crashes at <symbol>"))
//    func disabledTestOfBug() async throws {
//        <#body#>
//    }
//    
//    @Test
//    @available(macOS 15, *)
//    func sepecificOS() async throws {
//        <#body#>
//    }
}
