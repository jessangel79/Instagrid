//
//  UIImagePickerController.swift
//  Instagrid
//
//  Created by Angelique Babin on 09/05/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    open override var shouldAutorotate: Bool {
        return true
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
