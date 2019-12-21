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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upSharePicture(_ :)))
        upSwipe.direction = .up
        centerView.addGestureRecognizer(upSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSharePicture(_ :)))
        leftSwipe.direction = .left
        centerView.addGestureRecognizer(leftSwipe)
        
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
    
    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            self.swipeLabel.text = "Swipe left to share"
        } else {
            self.swipeLabel.text = "Swipe up to share"
        }
    }
    
    @objc func upSharePicture(_ sender: UISwipeGestureRecognizer) {
        switch layoutView.style {
        case 1, 2:
            if arrayPhotos.count < 3 {
                alertPhotoMissed()
            } else {
                shareCustomPictureWith(gesture: sender)
                }
        case 3:
            if arrayPhotos.count < 4 {
                alertPhotoMissed()
            } else {
                shareCustomPictureWith(gesture: sender)
            }
        default:
            break
        }
    }
    
    @objc func leftSharePicture(_ sender: UISwipeGestureRecognizer) {
        switch layoutView.style {
        case 1, 2:
            if arrayPhotos.count < 3 {
                alertPhotoMissed()
            } else {
                shareCustomPictureWith(gesture: sender)
            }
        case 3:
            if arrayPhotos.count < 4 {
                alertPhotoMissed()
            } else {
                shareCustomPictureWith(gesture: sender)
            }
        default:
            break
        }
    }
        
    private func shareCustomPictureWith(gesture: UISwipeGestureRecognizer) {
        let activityItem: [AnyObject] = [centerView.asImage()]
        let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)
        avc.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                return
            }
          //  self.centerView.transform = .identity
            self.resetCustomPicture()
        }
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
