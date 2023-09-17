//
//  APIManager.swift
//  collectionView
//
//  Created by Nurmukhanbet Sertay on 06.05.2023.
//

import Foundation
import UIKit
import XCTest

class APIManagerTests: XCTestCase {

    // Create a mock URL session for testing
    class MockURLSession: URLSession {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        override func dataTask(
            with url: URL,
            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
        ) -> URLSessionDataTask {
            let task = MockURLSessionDataTask()
            task.completionHandler = completionHandler
            task.data = data
            task.response = response
            task.error = error
            return task
        }
    }

    class MockURLSessionDataTask: URLSessionDataTask {
        var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
        var data: Data?
        var response: URLResponse?
        var error: Error?

        override func resume() {
            completionHandler?(data, response, error)
        }
    }

    var apiManager: APIManager!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        apiManager = APIManager()
        mockSession = MockURLSession()
        apiManager.urlSession = mockSession
    }

    override func tearDown() {
        apiManager = nil
        mockSession = nil
        super.tearDown()
    }

    func testLoadImages() {
        let id = 1
        let image = UIImage(named: "testImage") // Replace with an actual test image
        let imageData = image?.jpegData(compressionQuality: 1)
        let response = HTTPURLResponse(
            url: URL(string: "https://jsonplaceholder.typicode.com/photos/\(id)")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // Set up mock session to return image data
        mockSession.data = try? JSONEncoder().encode(ImageElement(url: "https://example.com/image.jpg"))
        mockSession.response = response

        let expectation = XCTestExpectation(description: "Completion called")

        apiManager.loadImages(id: id) { loadedImage in
            XCTAssertEqual(loadedImage, image, "Loaded image should match the expected image")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testLoadImageContent() {
        let imageUrl = "https://example.com/image.jpg"
        let image = UIImage(named: "testImage") // Replace with an actual test image
        let imageData = image?.jpegData(compressionQuality: 1)
        let response = HTTPURLResponse(
            url: URL(string: imageUrl)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // Set up mock session to return image data
        mockSession.data = imageData
        mockSession.response = response

        let expectation = XCTestExpectation(description: "Completion called")

        apiManager.loadImageContent(url: imageUrl) { loadedImage in
            XCTAssertEqual(loadedImage, image, "Loaded image should match the expected image")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
