//
//  ViewController.swift
//  Meme 1.0
//
//  Created by sundus on 22/07/1440 AH.
//  Copyright © 1440 sundus. All rights reserved.
//


import UIKit
import MobileCoreServices


class MemeEditorViewController:  UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate,
UITextFieldDelegate {
    
   
    
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var buttomText: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var viewImage: UIImageView!
    
    
    // meme 2.0
    
    var memes: [Memestruct]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    
    let imagePicker = UIImagePickerController()
    
    
    // Text setting
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -4
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTextField(topText)
        prepareTextField(buttomText)
       
    }
    
    
    func prepareTextField(_ textField: UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
        topText.delegate = self
        buttomText.delegate = self

    }
    
    
    @IBAction func textFieldDidEndEditing(_ sender: UITextField) {
        let text = sender.text ?? ""
        if text.isEmpty {
            if sender == topText {
                sender.text = "Top"
            } else {
                sender.text = "Bottom"
            }
        }
    }
    
    //Keyboard setting
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = (topText.isFirstResponder) ? 0 : getKeyboardHeight(notification)

    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return -keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
 }
    
    
    
    
    @IBAction func cancelButton(_ sender: Any) {
        
        self.viewImage.image = nil
        self.topText.text = "Top"
        self.buttomText.text = "Bottom"
        self.dismiss(animated: true)

    }
    

    // Image
    
    func image_ (_ sender: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func imageFromCameraOrGaller(_ sender: UIBarButtonItem) {
        let alart = UIAlertController(title: "Select Image From", message: "", preferredStyle: .actionSheet)
        
        
        let fromCamera = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                self.image_(UIImagePickerController.SourceType.camera)

               }
            
                
            else {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        let fromGallery = UIAlertAction(title: "Gallery", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                self.image_(UIImagePickerController.SourceType.photoLibrary)

            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Click cancel")
            }
        alart.addAction(fromGallery)
        alart.addAction(fromCamera)
        alart.addAction(cancel)
        self.present(alart, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        viewImage.image = image
        dismiss(animated:true, completion: nil)
    }



    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        
        self.toolBar.isHidden = true
        self.navBar.isHidden = true
        
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        self.toolBar.isHidden = false
        self.navBar.isHidden = false
        
        return memedImage
    }
    
    
    func save() {
        // Create the meme
        let meme = Memestruct(topText: self.topText.text!, bottomText: self.buttomText.text!, orgImage: self.viewImage.image!, combiningImage: generateMemedImage())
        MemeDatabase.sheard().dataSources.append(meme)
    dismiss(animated: true)
       
    }
    
    //Share Image

    
    @IBAction func shereButton(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [generateMemedImage()],
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.completionWithItemsHandler = { (activity, completed, items, error) in
            if completed {
                self.save()
            } else {
                print("Did not go well")
            }
        }
             self.present(activityViewController, animated: true, completion: nil)

        }
    
    
    }




