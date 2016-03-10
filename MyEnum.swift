//
//  MyEnum.swift
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

import Foundation
import UIKit

enum Icon {
    case Color(UIColor)
    case Image(UIImage)
}

class IconView: UIView {
    private var icon:Icon?
    
    init(icon:Icon) {
        self.icon = icon
        super.init(frame: CGRectZero)
        
        switch icon {
        case let .Color(color):
            self.backgroundColor = color
        case let .Image(image):
            let backgroundImage = UIColor(patternImage: image)
            self.backgroundColor = backgroundImage
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
