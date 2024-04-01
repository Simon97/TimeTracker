//
//  BoardViewViewModel.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 01/04/2024.
//

import Combine // TODO: Check what Combine can be used for in this context
import Foundation
import Observation

extension BoardView {
        
    @Observable
    class ViewModel {
        
        var board: Board
        
        init(board: Board) {
            self.board = board
        }
    }
}
