//
//  Stub.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

class Stub<Input, Output> {
    private(set) var calls = [Input]()
    private let inputHandler: (Input) -> Output
    
    init(inputHandler: @escaping (Input) -> Output) {
        self.inputHandler = inputHandler
    }
    
    func callAsFunction(_ input: Input) -> Output {
        calls.append(input)
        return inputHandler(input)
    }
}

extension Stub {
    static func failing(file: StaticString = #file, line: UInt = #line) -> Stub {
        Stub { _ in fatalError("Stub not implemented!", file: file, line: line) }
    }
}
