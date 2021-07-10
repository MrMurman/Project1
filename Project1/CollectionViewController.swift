//
//  CollectionViewController.swift
//  Project1
//
//  Created by Андрей Бородкин on 10.07.2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    var pictures = [Picture]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadData()
               
        
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Storm", for: indexPath)
        
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 7
        cell.layer.borderColor = UIColor(white: 0.0, alpha: 1).cgColor
        
        let cellImage = cell.viewWithTag(1) as? UIImageView
        let cellLabel = cell.viewWithTag(2) as? UILabel
        
        cellImage?.image = UIImage(named: pictures[indexPath.item].name)
        cellImage?.layer.borderWidth = 2
        cellImage?.layer.cornerRadius = 7
        cellImage?.layer.borderColor = UIColor(white: 0.7, alpha: 1).cgColor
        
        cellLabel?.text = pictures[indexPath.item].name
        
        
        return cell
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        pictures[indexPath.item].numberOfTaps += 1
//        savePicturesInfo()
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item].name
            navigationController?.pushViewController(vc, animated: true)
            vc.detailVCTitle = "Picture \(indexPath.item+1) of \(pictures.count)"
        }
    }
    
    
    func loadData() {
        let decoder = JSONDecoder()
        if let savedPics = defaults.object(forKey: "savedPics") as? Data {
            guard let savedData = try? decoder.decode([Picture].self, from: savedPics) else {return}
            pictures = savedData
        }
        
        collectionView.reloadData()
    }

//    func savePicturesInfo() {
//
//        let coder = JSONEncoder()
//        if let dataToSave = try? coder.encode(pictures){
//            defaults.set(dataToSave, forKey: "savedPics")
//        }
//
//        collectionView.reloadData()
//    }
    
    
}
