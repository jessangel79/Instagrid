//
//  ViewController.swift
//  Instagrid
//
//  Created by Angelique Babin on 29/04/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Vars
    private var tagImage: Int?
    private var swipeGesture = UISwipeGestureRecognizer()
    
    // MARK: - Outlets
    @IBOutlet var buttonsLayout: [UIButton]!
    @IBOutlet weak var photoView: PhotoView!
    @IBOutlet weak var swipe: UIStackView!
    
    // MARK: - Actions
    @IBAction func buttonLayoutTap(_ sender: UIButton) {
        for buttonLayout in buttonsLayout {
            buttonLayout.isSelected = false
            sender.isSelected = true
            switch sender.tag {
            case 0:
                photoView.layoutStyle = .layout1
            case 1:
                photoView.layoutStyle = .layout2
            case 2:
                photoView.layoutStyle = .layout3
            default:
                break
            }
        }
    }
    
    // Button to load an image
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        tagImage = sender.tag
        pickedPhotoLibrary()
    }

    // ### BONUS : button to reset all images ###
    @IBAction func resetPhotoViewButton() {
        alertReset()
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeGestureRecognizer()
    }
    
    // --- UIImagePickerControllerDelegate Methods : to interact with the image picker interface
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let tag = tagImage else { return }
            let imageView = photoView.imagesView[tag]
            imageView.image = pickedImage
            let button = photoView.imagesButton[tag]
            button.isHidden = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageView(gesture:)))
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true, completion: nil)
    }
    
    // --- UIImagePickerController : manages the system interfaces choosing items from the user's media library
    private func pickedPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func tapImageView(gesture: UITapGestureRecognizer) {
        tagImage = gesture.view?.tag
        pickedPhotoLibrary()
    }
    
    // --- UISwipeGestureRecognizer : for swiping gestures in one or more directions
    private func swipeGestureRecognizer() {
        let directionsSwipe = [UISwipeGestureRecognizer.Direction.up, UISwipeGestureRecognizer.Direction.left]
        for direction in directionsSwipe {
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(actionSwipe(gesture:)))
            photoView.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = direction
        }
    }
    
    // Swipe action - Slide up or left depending on device orientation
    @objc private func actionSwipe(gesture: UISwipeGestureRecognizer) {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let translationTransformLeft = CGAffineTransform(translationX: -screenWidth, y: 0)
        let translationTransformUp = CGAffineTransform(translationX: 0, y: -screenHeight)

        if gesture.direction == .up && UIDevice.current.orientation.isPortrait {
            UIView.animate(withDuration: 0.4, animations: {self.photoView.transform = translationTransformUp})
            print("Swipe up")
            shareImages()
        } else if gesture.direction == .left && UIDevice.current.orientation.isLandscape { //  UISwipeGestureRecognizer.Direction.left && (UIDeviceOrientation.landscapeLeft.isLandscape || UIDeviceOrientation.landscapeRight.isLandscape)
            UIView.animate(withDuration: 0.4, animations: {self.photoView.transform = translationTransformLeft})
            print("Swipe left")
            shareImages()
        }
    }
    
    // Shares the images if the grid is complete
    private func shareImages() {
        if checkIfPhoto() {
            guard let imagesToShare = photoView.transformViewToImage() else { return }
            let activityViewController = UIActivityViewController(activityItems: [imagesToShare], applicationActivities: nil)
            activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if completed {
                    self.alert(title: "Shared", message: "The share was successful")
                    print("Share OK")
                } else {
                    self.alert(title: "Not shared", message: "The share has not completed")
                    print("No Shared")
                }
                self.returnAnimateIdentityPhotoView()
            }
            present(activityViewController, animated: true, completion: nil)
        } else {
            alert(title: "Alert", message: "There is no photo to share")
            returnAnimateIdentityPhotoView()
            print("Alert no photo")
        }
    }
    
    // Main grid automatically returns to its original place by reverse animation.
    private func returnAnimateIdentityPhotoView() {
        UIView.animate(withDuration: 0.4, animations: {self.photoView.transform = .identity})
    }
    
    // ### BONUS - Checks if there is a photo into the grid ###
    private func checkIfPhoto() -> Bool {
        for imageView in photoView.imagesView {
            if imageView.image != nil {
                print("photo OK")
                return true
            }
        }
        print("No photo")
        return false
    }
    
    // Displays an alert message to the user
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // ### BONUS - Displays an alert message to the user to confirm photo reset ###
    private func alertReset() {
        if checkIfPhoto() {
            let alertReset = UIAlertController(title: "Reset", message: "Do you want to reset all the photos ?", preferredStyle: .alert)
            alertReset.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.photoView.resetPhotoView()
            }))
            alertReset.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            present(alertReset, animated: true, completion: nil)
        } else {
            alert(title: "Alert", message: "There is no photo")
            print("Alert no photo")
        }
    }
}

