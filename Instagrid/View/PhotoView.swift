//
//  PhotoView.swift
//  Instagrid
//
//  Created by Angelique Babin on 02/05/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

// PhotoView inherits of UIView class and defines the photos grid view
class PhotoView: UIView {

    enum LayoutStyle {
        case layout1, layout2, layout3
    }
    
    // MARK: - Outlets
    @IBOutlet var photoStackView: UIStackView!
    @IBOutlet var topStackView: UIStackView!
    @IBOutlet var downStackView: UIStackView!
    @IBOutlet var imagesView: [UIImageView]!
    @IBOutlet var imagesButton: [UIButton]!
    
    // MARK: - Vars
    var layoutStyle: LayoutStyle = .layout2 {
        didSet {
            setLayoutStyle(layoutStyle)
        }
    }
    
    private var tagImageView: Int = 0
    
    // MARK: - Methods
    // Displays views based on layout style 1, 2 or 3
    private func setLayoutStyle(_ layoutStyle: LayoutStyle) {
        switch layoutStyle {
        case .layout1:
            topStackView.viewWithTag(1)?.isHidden = true
            downStackView.viewWithTag(3)?.isHidden = false
        case .layout2:
            topStackView.viewWithTag(1)?.isHidden = false
            downStackView.viewWithTag(3)?.isHidden = true
        case .layout3:
            topStackView.viewWithTag(1)?.isHidden = false
            downStackView.viewWithTag(3)?.isHidden = false
        }
    }
    
    // Reset photoView - delete all images and reset all buttons
    func resetPhotoView() {
        deleteImagesView()
        resetImagesButton()
    }
    
    // Delete all images in array "imagesView"
    private func deleteImagesView() {
        for imageView in imagesView {
            deleteImageView(imageView)
        }
    }
    
    // Delete an image
    private func deleteImageView(_ imageView: UIImageView) {
        imageView.image = nil
    }
    
    // Reset all buttons in array "imagesButton"
    private func resetImagesButton() {
        for button in imagesButton {
            button.isHidden = false
        }
    }
}
