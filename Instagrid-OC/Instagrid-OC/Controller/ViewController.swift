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
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upSharePicture(_:)))
        upSwipe.direction = UISwipeGestureRecognizerDirection.up
        centerView.addGestureRecognizer(upSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSharePicture(_:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        centerView.addGestureRecognizer(leftSwipe)
        
        setLayout(layout: 2)
        setCenterView(layout: 2)
    }

    // Outlets
    @IBOutlet weak var instagridLabel: UILabel!
    @IBOutlet weak var swipeView: UIStackView!
    @IBOutlet weak var swipeImageView: UIImageView!
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            self.swipeLabel.text = "Swipe left to share"
            swipeImageView.image = #imageLiteral(resourceName: "Arrow Left")
        } else {
            self.swipeLabel.text = "Swipe up to share"
            swipeImageView.image = #imageLiteral(resourceName: "Arrow Up")
        }
    }
    
    @objc func upSharePicture(_ sender: UISwipeGestureRecognizer) {
        switch layoutView.style {
        case 1, 2:
            if arrayPhotos.count < 3 {
                alertPhotoMissed()
            } else {
                shareCustomPictureWith(gesture: sender)
                UIView.animate(withDuration: 0.8, animations: {
                    self.moveTop(view: self.centerView)
                }) { (finished) in
                    if finished {
                        UIView.animate(withDuration: 0.8, animations: {
                            self.moveDown(view: self.centerView)
                        })
                    }
                }
            }
        case 3:
            if arrayPhotos.count < 4 {
                alertPhotoMissed()
            } else {
                shareCustomPictureWith(gesture: sender)
                UIView.animate(withDuration: 0.8, animations: {
                    self.moveTop(view: self.centerView)
                }) { (finished) in
                    if finished {
                        UIView.animate(withDuration: 0.8, animations: {
                            self.moveDown(view: self.centerView)
                        })
                    }
                }
            }
        default:
            break
        }
    }
    
    private func moveTop(view: CenterView) {
        view.center.y -= 200
    }
    
    private func moveDown(view: CenterView) {
        view.center.y += 200
    }
    
    @objc func leftSharePicture(_ sender: UISwipeGestureRecognizer) {
        switch layoutView.style {
        case 1, 2:
            if arrayPhotos.count < 3 {
                alertPhotoMissed()
            } else {
                shareCustomPictureWith(gesture: sender)
                UIView.animate(withDuration: 0.8, delay: 0, animations: {
                    self.moveLeft(view: self.centerView)
                }) { (finished) in
                    if finished {
                        UIView.animate(withDuration: 0.8, animations: {
                            self.moveRight(view: self.centerView)
                        })
                    }
                }
            }
        case 3:
            if arrayPhotos.count < 4 {
                alertPhotoMissed()
            } else {
                shareCustomPictureWith(gesture: sender)
                UIView.animate(withDuration: 0.8, delay: 0, animations: {
                    self.moveLeft(view: self.centerView)
                }) { (finished) in
                    if finished {
                        UIView.animate(withDuration: 0.8, animations: {
                            self.moveRight(view: self.centerView)
                        })
                    }
                }
            }
        default:
            break
        }
    }
    
    private func moveLeft(view: CenterView) {
        view.center.x -= 200
    }
    
    private func moveRight(view: CenterView) {
        view.center.x += 200
    }
    
    private func shareCustomPictureWith(gesture: UISwipeGestureRecognizer) {
        let activityItem: [AnyObject] = [centerView.asImage()]
        let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)
        avc.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                return
            }
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
