//
//  UIView-extensions.swift
//  Instagrid
//
//  Created by Angelique Babin on 14/05/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

extension UIView {
    
    // Transform UIView to UIImage
    func transformViewToImage() -> UIImage? {
        let rect: CGRect = self.frame
        
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return img
        }
        return nil
    }
}
