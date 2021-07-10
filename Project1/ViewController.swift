//
//  ViewController.swift
//  Project1
//
//  Created by Андрей Бородкин on 20.06.2021.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [Picture]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
               
        let decoder = JSONDecoder()
        if let savedPics = defaults.object(forKey: "savedPics") as? Data {
            guard let savedData = try? decoder.decode([Picture].self, from: savedPics) else {return}
            pictures = savedData
        } else {
            DispatchQueue.global(qos: .default).async { [weak self] in
                let fm = FileManager.default
                let path = Bundle.main.resourcePath!
                let items = try! fm.contentsOfDirectory(atPath: path)
                
                for item in items {
                    if item.hasPrefix("nssl"){
                        // this is a pic to load
                        self?.pictures.append(Picture(name: item))
                    }
                }
                self?.pictures = (self?.pictures.sorted())!
                
                self?.savePicturesInfo()
//                let coder = JSONEncoder()
//                if let dataToSave = try? coder.encode(self?.pictures){
//                    defaults.set(dataToSave, forKey: "savedPics")
//                }
                
            }
        }
        
        
       
       // tableView.reloadData()
        
        
        
        
        print(pictures)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row].name
        cell.detailTextLabel?.text = "Number of taps \(pictures[indexPath.row].numberOfTaps)"
        cell.detailTextLabel?.textColor = .lightGray
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pictures[indexPath.row].numberOfTaps += 1
        savePicturesInfo()
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row].name
            navigationController?.pushViewController(vc, animated: true)
            vc.detailVCTitle = "Picture \(indexPath.row+1) of \(pictures.count)"
        }
    }
    
    func savePicturesInfo() {
        
        let coder = JSONEncoder()
        if let dataToSave = try? coder.encode(pictures){
            defaults.set(dataToSave, forKey: "savedPics")
        }
        
        tableView.reloadData()
    }

}

