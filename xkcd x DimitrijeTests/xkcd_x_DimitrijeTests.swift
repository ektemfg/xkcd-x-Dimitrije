//
//  xkcd_x_DimitrijeTests.swift
//  xkcd x DimitrijeTests
//
//  Created by Dimitrije Pesic on 24/04/2023.
//

import XCTest
@testable import xkcd_x_Dimitrije

final class xkcd_x_DimitrijeTests: XCTestCase {
    
    var viewModel: ViewModel!
    let dummyComic = Comic(month: "April", num: 23, link: "https://dummylink.com/", year: "2023", news: "I made xkcd app", safeTitle: "Very safe title", transcript: "I love transcript", alt: "Just some strings", img: "https://google.com/favicon.ico", title: "Shortcut rocks", day: "Monday")
    
    override func setUp() {
        super.setUp()
        viewModel = ViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Test Add/Remove Favs
    func testFavOrRemove() {
        XCTAssertFalse(viewModel.favouriteComics.contains{ comic in
            return comic.num == dummyComic.num
        }, "Make sure fav comics does not contain dummyComic")
        // Add dummy comic to fav comics.
        viewModel.favOrRemove(comic: dummyComic)
        XCTAssertTrue(viewModel.favouriteComics.contains{ comic in
            return comic.num == dummyComic.num
        }, "FavouriteComics should contain dummyComic")
        // Run favOrRemove - it will remove dummyComic if it is in the list
        viewModel.favOrRemove(comic: dummyComic)
        XCTAssertFalse(viewModel.favouriteComics.contains{ comic in
            return comic.num == dummyComic.num
        }, "Fav Comic should have deleted dummyComic")
    }
    
    // Test Save / Load Favs from UserDefaults
    func testLoadFavourites() {
        XCTAssertFalse(viewModel.favouriteComics.contains{ comic in
            return comic.num == dummyComic.num
        }, "Make sure fav comics does not contain dummyComic at first")
        // Encode dummyComic to JSON as a array.
        let dummyComicsData = try! JSONEncoder().encode([dummyComic])
        //  Save dummyComic to userDefaults
        UserDefaults.standard.set(dummyComicsData, forKey: "favourites")
        // Load favs from userdefaults - it will decode them and put in array
        viewModel.loadFavourites()
        XCTAssertTrue(viewModel.favouriteComics.contains{ comic in
            return comic.num == dummyComic.num
        }, "FavouriteComics should contain dummyComic now")
        
    }
    
    func testGetCurrent() {
        let expectation = XCTestExpectation(description: "Fetch current comic")
        
        // Let's make sure comic is nil
        XCTAssertNil(viewModel.currentComic, "Make sure current comic.num is nil")
        XCTAssertFalse(viewModel.currentComic?.num == 2766, "Make sure current comic.num is not 2766")
        
        // Run function and wait a little bit for completion since its async.
        viewModel.getCurrent()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // 5 sec should be more than enough
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 15.0)
        
        // Check if current comic is not nil and has the number we hardcoded as max
        XCTAssertNotNil(viewModel.currentComic, "Make sure current comic is not nil")
        XCTAssertNotNil(viewModel.currentComic?.num, "Make sure current comic.num is not nil")
        XCTAssertTrue(viewModel.currentComic?.num == 2766, "Make sure current comic.num is indeed 2766 after getCurrent")
    }
    
    func testGetSpecific() {
        let expectation = XCTestExpectation(description: "Fetch specific comic")
        
        // Let's make sure comic is nil
        XCTAssertNil(viewModel.currentComic, "Make sure current comic.num is nil")
        XCTAssertFalse(viewModel.currentComic?.num == 1337, "Make sure current comic.num is not 1337")
        
        // Run function and wait a little bit for completion since its async.
        viewModel.getSpecific(number: 1337)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // 5 sec should be more than enough
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 15.0)
        
        // Check if current comic is not nil and has the number we asked for.
        XCTAssertNotNil(viewModel.currentComic, "Make sure current comic is not nil")
        XCTAssertNotNil(viewModel.currentComic?.num, "Make sure current comic.num is not nil")
        XCTAssertTrue(viewModel.currentComic?.num == 1337, "Make sure current comic.num is indeed 1337 after getSpecific")
    }
    
    func testGetRandom() {
        // Let's make sure comic is nil
        XCTAssertNil(viewModel.currentComic, "Make sure current comic is nil")
        XCTAssertNil(viewModel.currentComic?.num, "Make sure current comic.num is nil")

        // Fetch first random comic
        let expectation1 = XCTestExpectation(description: "Fetch first random comic")
        viewModel.getRandom()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { // Wait 10 sec
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 15.0) // We give it some extra time.

        // Check the first comic's number and make sure it's not nil
        let firstNum = viewModel.currentComic!.num
        XCTAssertNotNil(viewModel.currentComic, "Make sure current comic is NOT nil")
        XCTAssertNotNil(viewModel.currentComic?.num, "Make sure current comic.num is NOT nil")

        // Fetch second random comic
        let expectation2 = XCTestExpectation(description: "Fetch second random comic")
        viewModel.getRandom()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { // Wait for 10 seconds
            expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 15.0) // We give it some extra time again

        // Check the second comic's number and make sure it's not nil
        let secondNum = viewModel.currentComic!.num
        XCTAssertNotNil(viewModel.currentComic, "Make sure current comic is NOT nil")
        XCTAssertNotNil(viewModel.currentComic?.num, "Make sure current comic.num is NOT nil")

        // Check that the two comics have different comic nums
        XCTAssertTrue(firstNum != secondNum, "We make sure we got different comic.nums from two requests")
    }

    
    


    
    
    
    
    
    
    
    
    
    
    
}
