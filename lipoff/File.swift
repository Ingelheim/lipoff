import UIKit
import AVFoundation

class VideoViewController: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    
    @IBAction func record(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var image = UIImageView(image: UIImage(named: "george"))
//        image.contentMode = UIViewContentMode.Center
        image.frame = view.frame
        image.contentMode = UIViewContentMode.ScaleAspectFit
        
//        view.addSubview(image)
        
        view.addSubview(image)
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        let devices = AVCaptureDevice.devices()

        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo)) {
                if(device.position == AVCaptureDevicePosition.Front) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        println("Capture device found")
                        beginSession()
                    }
                }
            }
        }
        
        view.bringSubviewToFront(image)
    }
    
    func beginSession() {
        var err : NSError? = nil
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
//        previewLayer.
        previewLayer?.frame = self.view.frame
        
        captureSession.startRunning()
        
        
        
    }
}