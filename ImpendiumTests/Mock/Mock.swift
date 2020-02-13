//
//  Mock.swift
//  RealtorTests
//
//  Created by Trujillo, Tomas on 2019-08-06.
//  Copyright © 2019 Move, Inc. All rights reserved.
//

import Foundation
import UIKit

/// Use this protocol in the class you want to mock. The methods that you want mocked should use the perfom methods to capture the parameters and mock the answer
protocol Mockable {}

extension Mockable {
    /// Adds an invocation, with its parameters, to the mock. Retruns a mocked value
    ///
    /// - Parameters:
    ///   - _: Mock method that was invoked
    ///   - parameters: Parameters with which the method was called. If there is more than one parameters pass it as a tuple (i.e parameters: (param1, param2)
    /// - Returns: Returns the mocked value. Make sure to have assigned a mock value for this method or else a fatal error will occur
    func performAndReturn<T>(_ mock: Mock, parameters: Any) -> T {
        mock.invocations.append(parameters)
        mock.performClosure?(parameters)
        guard let result = mock.result as? T else {
            fatalError("Missing implementation for mock")
        }
        return result
    }

    /// Adds an invocation, with its parameters, to the mock. Retruns a mocked value
    ///
    /// - Parameters:
    ///   - _: Mock method that was invoked
    ///   - parameters: Parameters with which the method was called. If there is more than one parameters pass it as a tuple (i.e parameters: (param1, param2)
    /// - Returns: Returns the mocked value. Make sure to have assigned a mock value for this method or else a fatal error will occur
    func performAndReturn<T: ExpressibleByNilLiteral>(_ mock: Mock, parameters: Any) -> T {
        mock.invocations.append(parameters)
        mock.performClosure?(parameters)
        guard let result = mock.result as? T else {
            if mock.valueWasSet { return nil }
            fatalError("Missing implementation for mock")
        }
        return result
    }

    /// Adds an invocation, with its parameters, to the mock. Use for mocking Void methods
    ///
    /// - Parameters:
    ///   - _: Mock method that was invoked
    ///   - parameters: Parameters with which the method was called. If there is more than one parameters pass it as a tuple (i.e parameters: (param1, param2)
    func perform(_ mock: Mock, parameters: Any) {
        mock.performClosure?(parameters)
        mock.invocations.append(parameters)
    }
}

/// Use Mock to mock a method in a Mockable class
final class Mock {
    /// Invocations of the Mock. The number of items in this array represent the number of times the Mock was called.
    /// Each item contains the params used in the respective method call
    var invocations: [Any] = []
    fileprivate var result: Any? {
        didSet {
            valueWasSet = true
        }
    }

    fileprivate var valueWasSet = false
    fileprivate var performClosure: ((Any) -> Void)?

    /// Number of times the Mock was called
    var numberOfInvocations: Int {
        return invocations.count
    }

    /// Last invocation made to the Mock
    var lastInvocation: Any? {
        return invocations.last
    }

    /// Mock the outcome of the mocked method. Only useful if the Mock is being used in a method that returns
    ///
    /// - Parameter outcome: Value that will be returned in the mock method
    func mockOutcome(_ outcome: Any?) {
        result = outcome
    }

    /// Mock the outcome of the mocked mehtod. This mock is useful if you want to perform something with the params passed to the mocked method
    /// For example you would want a mocked method with a completion to be executed immediately with a mocked result.
    ///
    /// - Parameters:
    ///   - outcome: Value that will be returned in the mock method if necessary. If not just specify void ()
    ///   - closure: Code that will be executed before returning the mocked outcome
    func mockOutcome(_ outcome: Any?, performingWithParams closure: @escaping (Any) -> Void) {
        result = outcome
        performClosure = closure
    }

    /// Clear the invocation list. This method is useful, when in the setup of your tests, the mocked method is called.
    /// Clear the invocations before starting you test stimulations (i.e. sut.doSomething) to avoid unexpected results.
    func clearInvocations() {
        invocations = []
    }
}
