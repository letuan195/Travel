//
//  TimingDelegate.swift
//  Travel
//
//  Created by Elight on 5/8/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import Foundation
protocol TimingDelegate: class {
    func selecttRow(tag: Int, row: Int, playing: Bool)
}