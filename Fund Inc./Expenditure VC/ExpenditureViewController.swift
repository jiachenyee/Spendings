//
//  ViewController.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 13/9/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import UIKit
import Vision
import VisionKit

class ExpenditureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, VNDocumentCameraViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popUpView: PopUpView!
    @IBOutlet weak var customSelectionView: CustomSelectionButtons!
    
    var textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
    private let textRecognitionWorkQueue = DispatchQueue(label: "TextRecognitionQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customSelectionView.addAction(actionOne: { (actionOne) in
            // Launch OCR
            let scannerViewController = VNDocumentCameraViewController()
            scannerViewController.delegate = self
            self.present(scannerViewController, animated: true)
            print("Scanner Launched")
            
        }) { (actionTwo) in
            // Launch Pop-up
            self.popUpView.isHidden = false
        }
        
        popUpView.completion = { (_) in
            self.tableView.reloadData()
        }
        
        popFrame = popUpView.frame
        customSelectionView.tintColor = .black
        setupVision()
    }
    
    // MARK: TableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ExpenditureClass.loadFromFile() ?? []).count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == (ExpenditureClass.loadFromFile() ?? []).count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "filler", for: indexPath)
            return cell
        }
        
        let data = ExpenditureClass.loadFromFile() ?? []
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "spendings", for: indexPath) as! SpendingsTableViewCell
        
        cell.iconImageView.image = UIImage(systemName: "desktopcomputer")
        cell.curvedImageViewView.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0.7647058824, blue: 0.6980392157, alpha: 1)
        cell.titleLabel.text = data[indexPath.row].store
        
        // Setting the time
        var time = ""
        
        if data[indexPath.row].inputDate.timeIntervalSinceNow / 86400 <= 0 {
            time = "Today"
        } else if data[indexPath.row].inputDate.timeIntervalSinceNow / 86400 <= 1 {
            time = "Yesterday"
        } else {
            time = "\(data[indexPath.row].inputDate.timeIntervalSinceNow / 86400) days ago"
        }
        
        cell.costAndTimeLabel.text = "$\(String(format: "%.2f", data[indexPath.row].amount)) | \(time)"
        
        if data[indexPath.row].isSpending {
            cell.costAndTimeLabel.textColor = #colorLiteral(red: 0.8588235294, green: 0.3294117647, blue: 0.3803921569, alpha: 1)
            cell.arrowImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            cell.arrowImageView.tintColor = #colorLiteral(red: 0.8588235294, green: 0.3294117647, blue: 0.3803921569, alpha: 1)
        } else {
            cell.costAndTimeLabel.textColor = #colorLiteral(red: 0.5725490196, green: 0.6784313725, blue: 0.6, alpha: 1)
            cell.arrowImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            cell.arrowImageView.tintColor = #colorLiteral(red: 0.5725490196, green: 0.6784313725, blue: 0.6, alpha: 1)
        }
        
        return cell
    }
    
    // MARK: - Optical Character Recognition
    private func setupVision() {
        textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            var detectedText = ""
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { return }

                detectedText += topCandidate.string
                detectedText += "\n"
            }
            self.textRecognitionRequest.recognitionLevel = .accurate
            print(detectedText)
        }
        // Improving on the results of the scanned text
        textRecognitionRequest.usesLanguageCorrection = true
        textRecognitionRequest.recognitionLevel = .accurate
    }
    
    // MARK: - Setting the Scanning View Controllers
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        // Make sure the user scanned at least one page
        guard scan.pageCount >= 1 else {
            // If the user does not have any pages scanned, then dismiss the controller
            controller.dismiss(animated: true)
            return
        }
        
        // Processing of photo to work around a VisionKit Bug
        let originalImage = scan.imageOfPage(at: 0)
        let fixedImage = reloadedImage(originalImage)
        
        // After completing the scan, dismiss the controller
        controller.dismiss(animated: true)
        
        // Process the image
        recogniseTextInImage(fixedImage)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        // The VNDocumentCameraViewController failed with an error.
        // Print the error so that we would know what went wrong
        print(error)
        
        // Since there's an error, dismiss controller and get user to try again
        controller.dismiss(animated: true)
        
        // Inform the user that there was an error occured
        let alert = UIAlertController(title: "Error", message: "There was an error with the scanning of the receipt. Please try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default Action"), style: .default, handler: nil))
        present(alert, animated: true)

    }
    
     func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
         // If the user cancels the scan, you need to dismiss the controller
         controller.dismiss(animated: true)
     }
    
    // MARK: - Scan Handling
    /// Recognizes and displays the text from the image
    /// - Parameter image: `UIImage` to process and perform OCR on
    private func recogniseTextInImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        textRecognitionWorkQueue.async {
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try requestHandler.perform([self.textRecognitionRequest])
            } catch {
                print(error)
            }
        }
    }
    // MARK: - Image Loading Workaround
    
    func reloadedImage(_ originalImage: UIImage) -> UIImage {
        guard let imageData = originalImage.jpegData(compressionQuality: 1),
            let reloadedImage = UIImage(data: imageData) else {
                return originalImage
        }
        return reloadedImage
    }

}

