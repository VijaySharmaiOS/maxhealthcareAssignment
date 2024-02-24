//
//  DetailsViewController.swift
//  MaxHealthCare
//
//  Created by VJ on 23/02/24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: VARIABLES
    var selectedContent = String()
    
    // Topview
    private lazy var topview: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    // label text for content
    private lazy var lbltext: UILabel = {
        let label = UILabel()
        if let attributedString = attributedString(from: selectedContent) {
            label.attributedText = attributedString
        }
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: ViewdidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    internal var topStatusHeight : CGFloat{
        return 32
    }
    
    
    //MARK: SETUP UI
    func setupUI(){
        
        // top view constraint
        view.addSubview(topview)
        topview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topview.topAnchor.constraint(equalTo: view.topAnchor, constant: topStatusHeight),
            topview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topview.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //table view constraint
        self.view.addSubview(lbltext)
        lbltext.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lbltext.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lbltext.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lbltext.topAnchor.constraint(equalTo: topview.bottomAnchor , constant: 20), // Top anchor constraint modified
        ])
    }
    
    // Attribute text convert html string into label text
    func attributedString(from htmlString: String) -> NSAttributedString? {
        do {
            let attributedString = try NSAttributedString(data: Data(htmlString.utf8),
                                                          options: [.documentType: NSAttributedString.DocumentType.html],
                                                          documentAttributes: nil)
            return attributedString
        } catch {
            print("Error converting HTML: \(error.localizedDescription)")
            return nil
        }
    }
    
}
