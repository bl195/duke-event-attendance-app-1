//
//  QRCheckInViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Jessica Su on 6/25/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit
import Apollo
import RSBarcodes_Swift
import AVFoundation

/*
    This class is responsible for displaying the attendee's QR code (or barcode) so that
    it can be scanned by a host. The QR code/barcode is created based on the attendee's DUID.
*/
class QRCheckInViewController: UIViewController {
    var event:Event = Event(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!
    var qrcodeImage = CIImage()
    var isBarCode:Bool = false
    var dukeCard:String = ""
    var dukeUnique:String = ""
    var graphQLManager = GraphQLManager()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var qrImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Check In"
        showBarCode(barCode: isBarCode, nav: self.navigationController!)
        eventLabel.text = event.summary
        dateLabel.text = event.start_date
        locationLabel.text = event.address
    }
    
    /*
        Responsible for showing the QR code (can also show bar code) that is
        based on the attendee's DUID.
    */
    func showBarCode (barCode: Bool, nav: UINavigationController) {
        graphQLManager.getInfo(nav: nav){ duid, name, error in
            var data: Data
            var filter: CIFilter
            self.cardLabel.text = "DUID: " + duid
            self.nameLabel.text = name
            if (duid != nil) {
                if (barCode) {
                    self.qrImage.image = RSUnifiedCodeGenerator.shared.generateCode(duid, machineReadableCodeObjectType: AVMetadataObject.ObjectType.code39.rawValue)
                }
                else {
                    /*QR code options*/
                    data = duid.data(using:String.Encoding.isoLatin1, allowLossyConversion: false)!
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
    
    /*
        Handles the display for the image of the QRCode. 
    */
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
    
    
    /*
        GraphQL Query that returns the info about an attendee (name, cardnumber).
    */
//    func getInfo(nav: UINavigationController, completionHandler: @escaping (_ cardnumber: String, _ name: String, _ error: String?) -> Void ){
//                let query = GetMyInfoQuery()
//                Apollo().getClient().fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in
//                    if let error = error as? GraphQLHTTPResponseError {
//                        switch (error.response.statusCode) {
//                        case 401:
//                            //request unauthorized due to bad token
//                            OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
//                                if success {
//
//                                    self.getInfo(nav: nav) { cardnumber, name, error in
//                                        completionHandler(cardnumber, name, error)
//                                    }
//                                } else {
//                                    //handle error
//                                }
//
//                            }
//                        default:
//                            print (error.localizedDescription)
//                        }
//                    }
//                    else if (results?.data?.getMyInfo != nil ) {
//                        let data = results?.data?.getMyInfo
//                        completionHandler(data![3], data![1], nil)
//                    }
//                }
//    }
   

}
