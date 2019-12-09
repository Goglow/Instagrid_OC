//
//  ViewController.swift
//  Instagrid-OC
//
//  Created by Melissa GS on 06/12/2019.
//  Copyright © 2019 Goglow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var arrayPhotos = [UIImage]()
    var imageIndex = 0
    
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
        let imagePicked: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        centerView.upLeftButton?.setImage(imagePicked, for: .normal)
        centerView.upLeftButton?.imageView?.contentMode = .scaleAspectFill
        centerView.upRightButton?.setImage(imagePicked, for: .normal)
        centerView.upRightButton?.imageView?.contentMode = .scaleAspectFill
        centerView.downLeftButton?.setImage(imagePicked, for: .normal)
        centerView.downLeftButton?.imageView?.contentMode = .scaleAspectFill
        centerView.downRightButton?.setImage(imagePicked, for: .normal)
        centerView.downRightButton?.imageView?.contentMode = .scaleAspectFill
        arrayPhotos.append(imagePicked)
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
        swipeLabel.text = "Swipe up to share"
        if arrayPhotos.count != 0 {
            switch sender.state {
            case .began, .changed:
                shareCustomPictureWith(gesture: sender)
            case .cancelled, .ended:
                resetCustomPicture()
            default:
                break
            }
        } else {
            alertPhotoMissed()
        }
    }
    
    @objc func leftSharePicture(_ sender: UISwipeGestureRecognizer) {
        swipeLabel.text = "Swipe left to share"
        if arrayPhotos.count != 0 {
            switch sender.state {
            case .began, .changed:
                shareCustomPictureWith(gesture: sender)
            case .cancelled, .ended:
                resetCustomPicture()
            default:
                break
            }
        } else {
            alertPhotoMissed()
        }
    }
    
    private func shareCustomPictureWith(gesture: UISwipeGestureRecognizer) {
      /*  if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.Right :
                    println("User swiped right")
                    // decrease index first
                    imageIndex--
                    // check if index is in range
                    if imageIndex < 0 {
                        imageIndex = maxImages
                    }
                    image.image = UIImage(named: imageList[imageIndex])
                case UISwipeGestureRecognizerDirection.Left:
                    println("User swiped Left")
                    // increase index first
                    imageIndex++
                    // check if index is in range
                    if imageIndex > maxImages {
                        imageIndex = 0
                    }
                    image.image = UIImage(named: imageList[imageIndex])
                default:
                    break //stops the code/codes nothing.*/
    }
    
    private func resetCustomPicture() {
        arrayPhotos = []
    }
    
    private func alertPhotoMissed() {
        let message = "The minimum number of photos that must be added has not been reached."
        let alert = UIAlertController(title: "Minimum Not Reached", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(_: UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
