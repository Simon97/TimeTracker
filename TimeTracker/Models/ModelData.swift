//
//  ModelData.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 08/04/2024.
//

import Foundation
import Observation

/**
 The idea with this is to contain all model data and provide it using the @Environment attribute
 I have the feeling that it would not scale well, but how well should it scale?
 */

@Observable
class ModelData { // TODO: When to provide this ?
    var boards: [Board]
    
    init(boards: [Board]) {
        self.boards = boards
    }
}
