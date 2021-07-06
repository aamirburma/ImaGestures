//
//  ViewController.swift
//  ImaGestures
//
//  Created by Aamir Burma on 06/07/21.
//

import UIKit

private var flag = 1
class ViewController: UIViewController {

    /** Load view */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(myImageView)
        view.addSubview(myLabel)
        myImagePicker.delegate = self
        let tab = UITapGestureRecognizer(target: self, action: #selector(openImagepicker))
        view.addGestureRecognizer(tab)
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(Didpinch))
        view.addGestureRecognizer(pinch)
        let Rotation = UIRotationGestureRecognizer(target: self, action: #selector(Didrotation))
        view.addGestureRecognizer(Rotation)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(Didswipe))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(Didswipe))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(Didswipe))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(Didswipe))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(Didpan))
        view.addGestureRecognizer(pan)
    }
    
    /** Create Imageview for placed image*/
    private let myImageView : UIImageView = {
        let myImageView = UIImageView()
        myImageView.frame = CGRect(x: 100, y: 150, width: 200, height: 200)
        return myImageView
    }()
    
    /** Create image picker UI*/
    private let myImagePicker:UIImagePickerController = {
        let myImagePicker = UIImagePickerController()
        myImagePicker.allowsEditing = false
        return myImagePicker
    }()
    
    /** Create label for select image*/
    private let myLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Click here"
        myLabel.textColor = .black
        myLabel.font = myLabel.font.withSize(30)
        myLabel.backgroundColor = .red
        myLabel.layer.cornerRadius = 5
        myLabel.layer.masksToBounds = true
        myLabel.frame = CGRect(x: 20, y: 300, width: 350, height: 40)
        myLabel.textAlignment = .center
        myLabel.layer.shadowColor = UIColor.black.cgColor
        myLabel.layer.shadowRadius = 3.0
        myLabel.layer.shadowOpacity = 1.0
        myLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        myLabel.layer.masksToBounds = false
        return myLabel
    }()
}

/** Extension of View Controller */
extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    /** Hide label on Selection and dismiss picker */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            myImageView.image = selectedImage
        }
        picker.dismiss(animated: true)
        flag = 0
        myLabel.isHidden = true
    }
    
    /** Dismiss image picker controller*/
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    /** Open Image Picker*/
    @objc private func openImagepicker(_ gesture:UITapGestureRecognizer){
        if (flag == 1){
        myImagePicker.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.myImagePicker, animated: true)
        }
        }else{
            print("Only tab perform")
        }
    }
    
    /** Pitch Functionality*/
    @objc private func Didpinch(_ gesture:UIPinchGestureRecognizer){
        myImageView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    
    /** Rotate the image*/
    @objc private func Didrotation(_ gesture:UIRotationGestureRecognizer){
        myImageView.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    
    /** Swipe the image*/
    @objc private func Didswipe(_ gesture:UISwipeGestureRecognizer){
        if gesture.direction == .left   {
            UIView.animate(withDuration: 0.2){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x - 50, y: self.myImageView.frame.origin.y, width: 200, height: 200)
            }
        }else if gesture.direction == .right   {
            UIView.animate(withDuration: 0.2){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x + 50, y: self.myImageView.frame.origin.y, width: 200, height: 200)
            }
        }
        else if gesture.direction == .up   {
            UIView.animate(withDuration: 0.2){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x, y: self.myImageView.frame.origin.y - 50 , width: 200, height: 200)
            }
        }
        else if gesture.direction == .down   {
            UIView.animate(withDuration: 0.2){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x, y: self.myImageView.frame.origin.y + 50 , width: 200, height: 200)
            }
        }
    }
    
    /** Move the image on Pan location*/
    @objc private func Didpan(_ gesture:UIPanGestureRecognizer){
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        myImageView.center = CGPoint(x: x, y: y)
        print("Pan")
    }
}
