//
//  FilestoreViewController.swift
//  iOS-app
//
//  Created by Jaison on 03/11/17.
//  Copyright © 2017 Hasura. All rights reserved.
//

import UIKit
import Alamofire

class FilestoreViewController: UIViewController {

    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }

    @IBAction func onCancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onUploadPressed(_ sender: UIBarButtonItem) {
        guard let _ = Hasura.getSavedAuthToken() else {
            self.showAlert(title: "Upload not allowed", message: "Login first to upload files")
            return            
        }
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension FilestoreViewController:
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let data = UIImagePNGRepresentation(pickedImage) {
                Alamofire.upload(
                    data,
                    to: Hasura.URL.filestore.getURL() + "v1/file/" + UUID().uuidString,
                    method: .post,
                    headers: [
                        "Content-Type": "image/*",
                        "Authorization": "Bearer " + Hasura.getSavedAuthToken()!
                    ]
                )
                    .validate()
                    .responseJSON(completionHandler: { (response) in
                        switch response.result {
                        case .success(let value):
                            let fileId = (value as! [String: Any])["file_id"] as! String
                            let fileUrl = Hasura.URL.filestore.getURL() + "v1/file/" + fileId
                            self.showAlert(title: "File uploaded successfully", message: "The file can be downloaded at the link: \(fileUrl)")
                            break
                        case .failure(let error):
                            self.showAlert(title: "Failed to upload file", message: error.localizedDescription)
                            break
                        }
                    })
                
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
