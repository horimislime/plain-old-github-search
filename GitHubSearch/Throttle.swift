//
//  Throttle.swift
//  GitHubSearch
//
//  Created by horimislime on 2018/01/13.
//  Copyright © 2018 horimislime. All rights reserved.
//

import Foundation

final class Throttle {
    
    private let queue = DispatchQueue(label: "com.example.github-search.throttle")
    
    private var lastJob: DispatchWorkItem?
    private var lastRun = Date.distantPast
    private var runInterval: TimeInterval
    
    init(runInterval: TimeInterval) {
        self.runInterval = runInterval
    }
    
    func execute(block: @escaping () -> ()) {
        lastJob?.cancel()
        lastJob = DispatchWorkItem { [weak self] in
            self?.lastRun = Date()
            block()
        }
        
        let delay = Date().seconds(after: lastRun) > runInterval ? 0 : runInterval
        queue.asyncAfter(deadline: .now() + Double(delay), execute: lastJob!)
    }
}

private extension Date {
    func seconds(after date: Date) -> TimeInterval {
        return timeIntervalSince(date)
    }
}
