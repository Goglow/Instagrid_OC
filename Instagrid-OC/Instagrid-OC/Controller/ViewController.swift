//
//  ViewController.swift
//  Instagrid-OC
//
//  Created by Melissa GS on 06/12/2019.
//  Copyright © 2019 Goglow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Variables and constants:
    // This is the button currently used.
    var currentButton: UIButton?
    // It is an array storing the selected images.
    var arrayPhotos = [UIImage]()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    // ViewDidLoad:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the rotation of the device (portrait, landscape)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        // Set the possible directions of swipe (up, left)
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upSharePicture(_:)))
        upSwipe.direction = UISwipeGestureRecognizerDirection.up
        centerView.addGestureRecognizer(upSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSharePicture(_:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        centerView.addGestureRecognizer(leftSwipe)
        
        // Set the choice of default LayoutView and CenterView
        setLayout(layout: 2)
        setCenterView(layout: 2)
    }

    // Outlets:
    @IBOutlet weak var instagridLabel: UILabel!
    @IBOutlet weak var swipeView: UIStackView!
    @IBOutlet weak var swipeImageView: UIImageView!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var centerView: CenterView!
    @IBOutlet weak var layoutView: LayoutView!
    
    // Actions:
    // When we hit the button to insert a photo...
    @IBAction func didTapPhotoButton(_ sender: UIButton) {
        self.currentButton = sender
        addPicture()
    }
    
    private func setCenterView(layout: Int) {
        centerView.style = layout
    }
    // ...she is taken from the available catalog (in our case the library) and takes the place of the button.
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
        // This photo is added to the table and we then know how many photos are missing before providing additional action (sharing, recording...).
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            // Necessary to change the image and the label (here: left).
            self.swipeLabel.text = "Swipe left to share"
            swipeImageView.image = #imageLiteral(resourceName: "Arrow Left")
        } else {
            // Same for the second possibility (here: up).
            self.swipeLabel.text = "Swipe up to share"
            swipeImageView.image = #imageLiteral(resourceName: "Arrow Up")
        }
    }
    // If the number of photos is sufficient, we can then continue (share) otherwise we have an error message (portrait mode).
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
    // If the number of photos is sufficient, we can then continue (share) otherwise we have an error message (landscape mode).
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

    private func moveTop(view: CenterView) {
        view.center.y -= screenHeight
    }

    private func moveDown(view: CenterView) {
        view.center.y += screenHeight
    }

    private func moveLeft(view: CenterView) {
        view.center.x -= screenWidth
    }
    
    private func moveRight(view: CenterView) {
        view.center.x += screenWidth
    }
    
    // To share, we must make a swipe movement (up or left).
    private func shareCustomPictureWith(gesture: UISwipeGestureRecognizer) {
        let activityItem: [AnyObject] = [centerView.asImage()]
        // If the action is not completed, there is no animation and the CenterView is reset to the starting point.
        let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)
        avc.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                return
            }
            self.resetCustomPicture()
        }
        // If the action is good, there is an animation along the same lines as the swipe.
        self.present(avc, animated: true, completion: nil)
            if UIDevice.current.orientation.isLandscape {
                UIView.animate(withDuration: 0.6, animations: {
                    self.moveLeft(view: self.centerView)
                })
            } else {
                UIView.animate(withDuration: 0.6, animations: {
                    self.moveTop(view: self.centerView)
                })
            }
        // If the action is completed/finished, canceled or there is an error, the movement is reversed.
        avc.completionWithItemsHandler = { (activityType: UIActivityType?, completed:
            Bool, arrayReturnedItems: [Any]?, error: Error?) in
            // Completed/Finished mode.
            if completed {
                print("share completed")
                    if UIDevice.current.orientation.isLandscape {
                        UIView.animate(withDuration: 0.6, animations: {
                            self.moveRight(view: self.centerView)
                        })
                    } else {
                        UIView.animate(withDuration: 0.6, animations: {
                            self.moveDown(view: self.centerView)
                        })
                        self.resetCustomPicture()
                    }
                return
            } else {
                // Canceled mode.
                print("cancel")
                    if UIDevice.current.orientation.isLandscape {
                        UIView.animate(withDuration: 0.6, animations: {
                            self.moveRight(view: self.centerView)
                        })
                    } else {
                        UIView.animate(withDuration: 0.6, animations: {
                            self.moveDown(view: self.centerView)
                        })
                        self.resetCustomPicture()
                    }
            }
            // Error mode.
            if let shareError = error {
                print("error while sharing: \(shareError.localizedDescription)")
                    if UIDevice.current.orientation.isLandscape {
                        UIView.animate(withDuration: 0.6, animations: {
                            self.moveRight(view: self.centerView)
                        })
                    } else {
                        UIView.animate(withDuration: 0.6, animations: {
                            self.moveDown(view: self.centerView)
                        })
                        self.resetCustomPicture()
                }
            }
        }
    }
    
    // This private function allows you to reset the CenterView to zero after sharing or other action.
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
    // This private function allows you to report missing photos in the CenterView.
    private func alertPhotoMissed() {
        let message = "The minimum number of photos that must be added has not been reached."
        let alert = UIAlertController(title: "Minimum Not Reached", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(_: UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
// An extension to use UIImagePickerController in landscape orientation.
extension UIImagePickerController
{
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
}
