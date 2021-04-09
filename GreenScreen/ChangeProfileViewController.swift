//
//  ChangeProfileViewController.swift
//  GreenScreen
//
//  Created by Kevin Lin on 4/9/21.
//

import UIKit
import AlamofireImage
import Parse

class ChangeProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    @IBAction func onSubmitButton(_ sender: Any) {
        let profilePic = PFObject(className: "ProfilePicture")

        profilePic["author"] = PFUser.current()!
            
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
            
        profilePic["image"] = file
            
        profilePic.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            }else {
                print("error!")
            }
        }
    }
        
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
            
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
                
        } else {
            picker.sourceType = .photoLibrary
        }
            
        present(picker, animated: true, completion: nil)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
            
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
            
        imageView.image = scaledImage
            
        dismiss(animated: true, completion: nil)
        }
    }




 

