import UIKit
import AVFoundation
import Apollo

class QRScannerController: UIViewController {

    var event_id = ""
    @IBOutlet var messageLabel:UILabel!
    @IBOutlet var topbar: UIView!
    
    @IBAction func homeButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyAgendaViewController") as? MyAgendaViewController

        self.navigationController?.pushViewController(vc!, animated: false)
    }
    @IBAction func attendeesButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentAttendees") as? CurrentAttendeesTableViewController
        vc?.event_id = event_id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    var captureSession = AVCaptureSession()
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?

    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
//            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
        
        // Move the message label and top bar to the front
        view.bringSubviewToFront(messageLabel)
        view.bringSubviewToFront(topbar)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Helper methods
    var alertPrompt = UIAlertController()
    
    func launchApp(decodedURL: String) {
        
        captureSession.stopRunning()
        
        if presentedViewController != nil {
            return
        }
        
        let hnc = self.storyboard?.instantiateViewController(withIdentifier: "hostNav") as? UINavigationController
        
        
        alertPrompt = UIAlertController(title: "Result", message: "Duke ID: \(decodedURL)", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Check in", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            self.alertPrompt.dismiss(animated: true)
            self.loadAttendee(nav: hnc!, event_id: self.event_id, duid: "\(decodedURL)")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (action) -> Void in
            self.captureSession.startRunning()
        })
        
        alertPrompt.addAction(confirmAction)
        alertPrompt.addAction(cancelAction)
        
        //DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.present(self.alertPrompt, animated: true, completion: nil)
        //}
    }

}




extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                launchApp(decodedURL: metadataObj.stringValue!) //completion handler heref
                messageLabel.text = metadataObj.stringValue
            }
        }
    }
    
    func loadAttendee(nav: UINavigationController, event_id: String, duid: String) {
        print(event_id)
        print(duid)
        let createAttendeeMutation = QrCheckInMutation(eventid: event_id, duid: duid)
        Apollo().getClient().perform(mutation: createAttendeeMutation) { [unowned self] result, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.loadAttendee(nav: nav, event_id: event_id, duid: duid)
                        } else {
                            //handle error
                        }
                        
                    }
                default:
                    print ("error")
                }
            }
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
            else if (result?.data?.qrCheckIn?.id != nil) {
                print("success")
                print(result?.data?.qrCheckIn?.id ?? "no attendee")
                
                //self.alertPrompt.dismiss(animated: true, completion: nil)
                
                let alert = UIAlertController(title: "You have successfully checked in", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {
                    (action) -> Void in
                    self.captureSession.startRunning()
                    }))
                self.present(alert, animated: true)
                
                //self.launchApp(decodedURL: cardNumber)
            }
            else {
                print("failed")
                print(result?.data?.qrCheckIn?.id)
                
                //self.alertPrompt.dismiss(animated: true, completion: nil)
                
                let alert = UIAlertController(title: "Check-in denied", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {
                    (action) -> Void in
                    self.captureSession.startRunning()
                }))
                self.present(alert, animated: true)
                //self.viewDidLoad()
                //self.launchApp(decodedURL: cardNumber)
                
                //self.present(self.alertPrompt, animated: true)
                //guard for TWO KINDS OF ERRORS: 1) not valid student and 2) already checked in
                //self.invalidityCheck()
            }
            
        }
        
    }

    
}
