//
//  ViewController.swift
//  Instagrid-OC
//
//  Created by Melissa GS on 06/12/2019.
//  Copyright © 2019 Goglow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var currentButton: UIButton?
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
        
        setLayout(layout: 2)
        setCenterView(layout: 2)
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
        self.currentButton = sender
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
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagePicked: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        guard let button = currentButton else {
            return
        }
        button.setImage(imagePicked, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
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
        switch layoutView.style {
        case 1, 2:
            if arrayPhotos.count < 3 {
                alertPhotoMissed()
            } else {
                switch sender.state {
                case .began:
                    shareCustomPictureWith(gesture: sender)
                case .ended:
                    resetCustomPicture()
                default:
                    break
                }
            }
        case 3:
            if arrayPhotos.count < 4 {
                alertPhotoMissed()
            } else {
                switch sender.state {
                case .began:
                    shareCustomPictureWith(gesture: sender)
                case .ended:
                    resetCustomPicture()
                default:
                    break
                }
            }
        default:
            break
        }
    }
    
    @objc func leftSharePicture(_ sender: UISwipeGestureRecognizer) {
        swipeLabel.text = "Swipe left to share"
        switch layoutView.style {
        case 1, 2:
            if arrayPhotos.count < 3 {
                alertPhotoMissed()
            } else {
                switch sender.state {
                case .began:
                    shareCustomPictureWith(gesture: sender)
                case .ended:
                    resetCustomPicture()
                default:
                    break
                }
            }
        case 3:
            if arrayPhotos.count < 4 {
                alertPhotoMissed()
            } else {
                switch sender.state {
                case .began:
                    shareCustomPictureWith(gesture: sender)
                case .ended:
                    resetCustomPicture()
                default:
                    break
                }
            }
        default:
            break
        }
    }
        
    private func shareCustomPictureWith(gesture: UISwipeGestureRecognizer) {
        let activityItem: [AnyObject] = [self.upImageView.image as AnyObject]
        let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)
        self.present(avc, animated: true, completion: nil)
    }
    
    private func resetCustomPicture() {
        arrayPhotos.removeAll()
        centerView.upLeftButton?.backgroundColor = UIColor.white
        centerView.upLeftButton?.setImage(UIImage(named: "Plus"), for: .normal)
        centerView.upRightButton?.backgroundColor = UIColor.white
        centerView.upRightButton?.setImage(UIImage(named: "Plus"), for: .normal)
        centerView.downLeftButton?.backgroundColor = UIColor.white
        centerView.downLeftButton?.setImage(UIImage(named: "Plus"), for: .normal)
        centerView.downRightButton?.backgroundColor = UIColor.white
        centerView.downRightButton?.setImage(UIImage(named: "Plus"), for: .normal)
    }
    
    private func alertPhotoMissed() {
        let message = "The minimum number of photos that must be added has not been reached."
        let alert = UIAlertController(title: "Minimum Not Reached", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(_: UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
