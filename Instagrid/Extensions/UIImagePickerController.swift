//
//  UIImagePickerController.swift
//  Instagrid
//
//  Created by Angelique Babin on 09/05/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    
    // Returns a Boolean value indicating whether the view controller's contents should auto rotate
    open override var shouldAutorotate: Bool {
        return true
    }
    
    // Returns all of the interface orientations that the view controller supports
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
