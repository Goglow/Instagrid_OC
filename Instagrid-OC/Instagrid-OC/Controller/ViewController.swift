//
//  ViewController.swift
//  Instagrid-OC
//
//  Created by Melissa GS on 06/12/2019.
//  Copyright © 2019 Goglow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var upLeftImage: UIImageView!
    @IBOutlet weak var upRightImage: UIImageView!
    @IBOutlet weak var downLeftImage: UIImageView!
    @IBOutlet weak var downRightImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let upSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(upSharePicture(_ :)))
        upSwipeGestureRecognizer.direction = .up
        centerView.addGestureRecognizer(upSwipeGestureRecognizer)
        
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftSharePicture(_ :)))
        leftSwipeGestureRecognizer.direction = .left
        centerView.addGestureRecognizer(leftSwipeGestureRecognizer)
    }

    // Outlets
    @IBOutlet weak var instagridLabel: UILabel!
    @IBOutlet weak var swipeView: UIStackView!
    @IBOutlet weak var upImageView: UIImageView!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var centerView: CenterView!
    @IBOutlet weak var layoutView: LayoutView!
    
    // Actions
    @IBAction func didTapPhotoButton(_ sender: UIButton) {
        addPicture()
    }
    
    private func setCenterView(layout: Int) {
        centerView.style = layout
    }
    
    private func addPicture() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        upLeftImage.image = image; upRightImage.image = image; downLeftImage.image = image; downRightImage.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapLayoutButton(_ sender: UIButton) {
        setLayout(layout: sender.tag)
        setCenterView(layout: sender.tag)
    }
    
    private func setLayout(layout: Int) {
        layoutView.style = layout
    }
    
    @objc func upSharePicture(_ sender: UISwipeGestureRecognizer) {
        self.swipeLabel.text = "Swipe up to share"
        switch sender.state {
        case .began, .changed:
            shareCustomPictureWith(gesture: sender)
        case .cancelled, .ended:
            resetCustomPicture()
        default:
            break
        }
    }
    
    @objc func leftSharePicture(_ sender: UISwipeGestureRecognizer) {
        self.swipeLabel.text = "Swipe left to share"
        switch sender.state {
        case .began, .changed:
            shareCustomPictureWith(gesture: sender)
        case .cancelled, .ended:
            resetCustomPicture()
        default:
            break
        }
    }
    
    private func shareCustomPictureWith(gesture: UISwipeGestureRecognizer) {
        
    }
    
    private func resetCustomPicture() {
        
    }
}
