//
//  AsurionTaskTests.swift
//  AsurionTaskTests
//
//  Created by Kalpesh on 27/06/20.
//  Copyright © 2020 Kalpesh Mahajan. All rights reserved.
//

import XCTest
import Alamofire
@testable import AsurionTask

class AsurionTaskTests: XCTestCase {

    var urlSession: URLSession!

    override func setUp() {
        super.setUp()
        urlSession = URLSession(configuration: .default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        urlSession = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }


    func testSettingAPICall() {
        let promise = expectation(description: "Status code: 200")
        AF.request(GET_SETTING, method: .get,headers: ["secret-key":SECRETE_KEY])
            .responseDecodable(of: SettingModel.self) { (response) in
                switch response.result {
                case .success( _):
                    promise.fulfill()
                case .failure(let error): break
                // error handling
                XCTFail("Status code: \(error)")
                }
        }
        wait(for: [promise], timeout: 5)
    }

    func testDecoding() throws {
        guard let path = Bundle.main.path(forResource: "Response", ofType: "json") else {
            return
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let response = try JSONDecoder().decode(SettingModel.self, from: data)
        // To fail this cases change values in response.json file.
        XCTAssertEqual(response.isCallEnabled, false)
        XCTAssertEqual(response.isChatEnabled, true)
    }

    func testWorkingHours() throws
    {
        // Change working hours string value
        let workingHours = "M-F 6:00 - 12:00"
        let arr = workingHours.components(separatedBy: " ")

        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        if let fromDate = dateFormatter.date(from: arr[1]),let toDate = dateFormatter.date(from: arr[3])
        {

            print(fromDate.hour12)
            print(toDate.hour12)


            let now = Date()
            print(now.hour12)

            if now.hour12 >= fromDate.hour12 && now.hour12 <= toDate.hour12 {

                XCTAssertTrue(true, "Thank you for getting in touch with us. We’ll get back to you as soon as possible")
            }
            else
            {

                XCTAssertTrue(false, "Work hours has ended. Please contact us again on the next work day")
            }

        }
        else{
            XCTFail("Invalid date")
        }
    }

  func testDateStringFormatLogic() {
    let workingHours = "M-F 6:00:00 - 12:00:00"
    let arr = workingHours.components(separatedBy: " ")
    let dateFormatter : DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    guard let fromDate = dateFormatter.date(from: arr[1]),
      let toDate = dateFormatter.date(from: arr[3]) else {
        XCTAssertNil(dateFormatter.date(from: arr[1]), "From date is nil")
        XCTAssertNil(dateFormatter.date(from: arr[3]), "To date is nil")
        return
    }
    XCTAssertNotNil(fromDate, "Valid from date")
    XCTAssertNotNil(toDate, "Valid to date")
  }
}
