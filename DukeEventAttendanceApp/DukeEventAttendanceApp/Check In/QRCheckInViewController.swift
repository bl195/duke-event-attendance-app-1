//
//  QRCheckInViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Jessica Su on 6/25/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

import RSBarcodes_Swift
import AVFoundation


class QRCheckInViewController: UIViewController {
    
    var qrcodeImage = CIImage()
    var isBarCode:Bool = false
    

    @IBOutlet weak var qrImage: UIImageView!
    
    func showBarCode (barCode: Bool) {
        
        Items.sharedInstance.getCard(){ cardnumber in
            var data: Data
            var filter: CIFilter
            if (cardnumber != nil) {
                if (barCode) {
                    self.qrImage.image = RSUnifiedCodeGenerator.shared.generateCode(cardnumber, machineReadableCodeObjectType: AVMetadataObject.ObjectType.code39.rawValue)
                }
                else {
                    /*QR code options*/
                    data = cardnumber.data(using:String.Encoding.isoLatin1, allowLossyConversion: false)!
                    filter = CIFilter(name: "CIQRCodeGenerator")!
                    filter.setValue(data, forKey: "inputMessage")
                    
                    if (data.count > 0) {
                        self.qrcodeImage = filter.outputImage!
                        self.displayQRCodeImage()
                    }
                    
                }
            }
        }
    

        
        
    }
    
    func displayQRCodeImage() {
        var scaleX: CGFloat
        
        var scaleY: CGFloat
        
        
        
        if (isBarCode) {
            
            scaleX = qrImage.frame.size.width / qrcodeImage.extent.size.width
            
            scaleY = qrImage.frame.size.height / qrcodeImage.extent.size.height
            
            let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            
            qrImage.image = UIImage(ciImage: transformedImage)
            
            
            
        } else {
            
            scaleX = qrImage.frame.size.height / qrcodeImage.extent.size.height
            
            scaleY = qrImage.frame.size.height / qrcodeImage.extent.size.height
            
            let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            
            qrImage.image = UIImage(ciImage: transformedImage)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Check In"
        //print (cardNumber)
        showBarCode(barCode: isBarCode)

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
