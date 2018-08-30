//
//  LinkingObjectTests.swift
//  PredicateFlow_Tests
//
//  Created by Andrea Del Fante on 30/08/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

class LinkingObjectTests: PredicateFlowRealmBaseTests {
    
    var testingElement: TestObject!
    
    override func setUp() {
        super.setUp()
        
        testingElement = realm.object(ofType: TestObject.self, forPrimaryKey: rangeOfElementsInRealm().indices.last!)
    }
    
    override func tearDown() {
        super.tearDown()
        
        testingElement = nil
    }
    
    func testFilter() {
        let expected = testingElement.parent.filter("int < %@", 17)
        let result = testingElement.parent.filter(TestObjectSchema.int.isLess(than: 17))
        
        PFRLMEqual(expected, result)
    }
    
    func testSorted() {
        [true, false].forEach {
            let expected = testingElement.parent.sorted(byKeyPath: "key", ascending: $0)
            let result = testingElement.parent.sorted($0 ? TestObjectSchema.key.ascending() : TestObjectSchema.key.descending())
            
            PFRLMEqual(expected, result)
        }
    }
}
