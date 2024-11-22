//
//  AboutVC.swift
//  SparkSupportMachineTest
//
//  Created by Salman Macbook Air M3 on 22/11/24.
//

import UIKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageURL = URL(string: "https://img.freepik.com/premium-vector/cute-smiling-sun-vector-icon_197792-591.jpg")!
        
        if let cachedImage = loadImageFromCache(url: imageURL) {
            self.imageView.image = cachedImage
        } else {
            downloadImage(from: imageURL)
        }
        // Do any additional setup after loading the view.
    }
    
    func downloadImage(from url: URL) {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            } catch {
                print("Error downloading image: \(error.localizedDescription)")
            }
        }
    }
    
    func loadImageFromCache(url: URL) -> UIImage? {
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    func saveImageToCache(image: UIImage, url: URL) {
        if let imageData = image.pngData() {
            let cachedResponse = CachedURLResponse(response: URLResponse(), data: imageData)
            URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
        }
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
