//
//  DocumentTableViewController.swift
//  Projet IOS
//
//  Created by Tristan GINET on 1/16/24.
//

import UIKit
import QuickLook
import MobileCoreServices

class DocumentTableViewController: UITableViewController, QLPreviewControllerDataSource, UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UISearchBarDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var fileList: [DocumentFile] = []
    
    var importedFileList: [DocumentFile] = [] {
        didSet {
            saveImportedFileList()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fileList = listFileInBundle().filter { $0.title.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
    
    func saveImportedFileList() {
        let storageImages = try? JSONEncoder().encode(importedFileList)
        UserDefaults.standard.set(storageImages, forKey: "importedFileList")
        
        if let savedData = UserDefaults.standard.data(forKey: "importedFileList") {
            if let loadedFileList = try? JSONDecoder().decode([DocumentFile].self, from: savedData) {
            }
        }
    }
    
    func loadFileList() -> [DocumentFile] {
        if let savedData = UserDefaults.standard.data(forKey: "importedFileList") {
            if let loadedFileList = try? JSONDecoder().decode([DocumentFile].self, from: savedData) {
                print(loadedFileList)
                return loadedFileList
            }
        }
        return [] as [DocumentFile]
    }
    
    struct DocumentFile: Codable {
        var title: String
        var size: Int
        var imageName: String? = nil
        var url: URL
        var type: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Liste des documents"
        searchBar.placeholder = "Your placeholder"
        searchBar.delegate = self
        
        fileList = listFileInBundle()
        importedFileList = loadFileList()
        
        tableView.reloadData()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImage))
    }

    @objc func addImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            copyFileToDocumentsDirectory(fromUrl: imageURL)

            let imageInfos = try! imageURL.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])

            importedFileList.append(
                DocumentFile(
                    title: imageInfos.name!,
                    size: imageInfos.fileSize ?? 0,
                    imageName: imageInfos.name!,
                    url: imageURL,
                    type: imageInfos.contentType!.description
                )
            )
            
            tableView.reloadData()
        }
    }
    
    func copyFileToDocumentsDirectory(fromUrl url: URL) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsDirectory.appendingPathComponent(url.lastPathComponent)

        do {
            try FileManager.default.copyItem(at: url, to: destinationUrl)
        } catch {
            print(error)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return fileList.count
        case 1:
            return importedFileList.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)

        var document: DocumentFile

        switch indexPath.section {
        case 0:
            document = fileList[indexPath.row]
        case 1:
            document = importedFileList[indexPath.row]
        default:
            fatalError("Invalid section")
        }

        cell.textLabel?.text = "\(document.title)"
        cell.detailTextLabel?.text = "\(document.size.formattedSize())"
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let sectionName: String
        switch section {
            case 0:
                sectionName = NSLocalizedString("Bundles", comment: "Bundles")
            case 1:
                sectionName = NSLocalizedString("Importations", comment: "Importations")
            default:
                sectionName = ""
        }
        return sectionName
    }
    
    // On utilise plus un segue, nous devons donc utiliser le navigationController pour afficher le QLPreviewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = fileList[indexPath.row]
        self.instantiateQLPreviewController(withUrl: file.url)
    }
    
    func instantiateQLPreviewController(withUrl url: URL) {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        
        if let index = tableView.indexPathForSelectedRow {
            previewController.currentPreviewItemIndex = index.row
            present(previewController, animated: true, completion: nil)
        }
    }

    @objc(numberOfPreviewItemsInPreviewController:) func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return fileList.count
    }

    @objc(previewController:previewItemAtIndex:) func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let selectedDocument = listFileInBundle()[index]
        return selectedDocument.url as QLPreviewItem
    }
    
    func listFileInBundle() -> [DocumentFile] {
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            var documentListBundle = [DocumentFile]()
        
            for item in items {
                if !item.hasSuffix("DS_Store") && item.hasSuffix(".jpg") {
                    let currentUrl = URL(fileURLWithPath: path + "/" + item)
                    let resourcesValues = try! currentUrl.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
                       
                    documentListBundle.append(DocumentFile(
                        title: resourcesValues.name!,
                        size: resourcesValues.fileSize ?? 0,
                        imageName: item,
                        url: currentUrl,
                        type: resourcesValues.contentType!.description)
                    )
                }
            }
            return documentListBundle
        }

}
