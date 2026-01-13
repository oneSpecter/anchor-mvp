//
//  CreateAnchorMode.swift
//  anchor
//
//  Created by Andrea Blasetti on 22/12/25.
//

import Foundation

enum CreateAnchorMode {
    case create
    case queueNext(anchorId: UUID)
}
