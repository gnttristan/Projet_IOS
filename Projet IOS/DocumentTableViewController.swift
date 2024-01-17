//
//  DocumentTableViewController.swift
//  Projet IOS
//
//  Created by Tristan GINET on 1/16/24.
//

import UIKit

class DocumentTableViewController: UITableViewController {
    
    struct DocumentFile {
        var title: String
        var size: Int
        var imageName: String? = nil
        var url: URL
        var type: String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Liste des documents"
   }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // On retroune les images dans le contenu racine du projet convertis en DocumentFile grâce à la fonction listFileInBundle()
        return listFileInBundle().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        
        // Onn récupère la bonne image depuis la fonction listFileInBundle() à l'aide de l'index indexPath entré en argument
        let document = listFileInBundle()[indexPath.row]
        
        cell.textLabel?.text = "\(document.title)"
        cell.detailTextLabel?.text = "\(document.size.formattedSize())"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = tableView.indexPathForSelectedRow {
            if let destination: DocumentViewController = segue.destination as? DocumentViewController {
                let selectedDocument = listFileInBundle()[index.row]
                destination.imageName = selectedDocument.imageName
            }
        }
        
        // 1. Récuperer l'index de la ligne sélectionnée
        // 2. Récuperer le document correspondant à l'index
        // 3. Cibler l'instance de DocumentViewController via le segue.destination
        // 4. Caster le segue.destination en DocumentViewController
        // 5. Remplir la variable imageName de l'instance de DocumentViewController avec le nom de l'image du document
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
