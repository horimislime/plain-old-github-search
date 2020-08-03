//
//  Throttle.swift
//  GitHubSearch
//
//  Created by horimislime on 2018/01/13.
//  Copyright © 2018 horimislime. All rights reserved.
//

import Foundation

final class Throttle {
    private let runInterval: TimeInterval
    private var lastRun = Date.distantPast
    
    init(runInterval: TimeInterval) {
        self.runInterval = runInterval
    }
    
    func execute(block: @escaping () -> ()) {
        let now = Date()
        guard now.seconds(after: lastRun) > runInterval else { return }
        block()
        lastRun = now
    }
}

private extension Date {
    func seconds(after date: Date) -> TimeInterval {
        return timeIntervalSince(date)
    }
}
