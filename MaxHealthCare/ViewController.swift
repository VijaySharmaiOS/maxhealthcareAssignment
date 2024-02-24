//
//  ViewController.swift
//  MaxHealthCare
//
//  Created by VJ on 21/02/24.
//

import UIKit
import KRProgressHUD
class ViewController: UIViewController {
    
    //MARK: VARIABLES
    var viewModel = TopicViewModel()
    var resuseidentifier = "TopicsCollectionViewCell"
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    // MARK: UI COMPONENTS
    // Topview to display label
    private lazy var topview: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    // Label to display text 
    private lazy var lbltext: UILabel = {
        let label = UILabel()
        label.text = "TOPICS"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    // Collection View
    let collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // Height for safe area
    internal var topStatusHeight : CGFloat{
        return 32
    }
    
    //MARK: ViewdidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        registercell()
        setScreenheightWidth()
        getTopics()
        setUpUI()
    }
    
    // register collection view
    func registercell(){
        collectionview.register(TopicsCollectionViewCell.self, forCellWithReuseIdentifier: resuseidentifier)
    }
    
    // get screen height and width
    func setScreenheightWidth(){
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
    }
    
    // Api call where we get the data
    func getTopics(){
        viewModel.fetchData { [weak self] result in
            DispatchQueue.main.async {
                KRProgressHUD.dismiss()
                switch result {
                case .success:
                    self?.collectionview.reloadData()
                case .failure(let error):
                    self?.handle(error)
                }
            }
        }
    }
    
    // error handling
    func handle(_ error: Error) {
        // Handle network error
        let errorMessage: String
        switch error {
        case NetworkError.invalidURL:
            errorMessage = "Invalid URL"
        case NetworkError.unknownError:
            errorMessage = "Unknown error occurred"
            // Handle other specific error cases if needed
        default:
            errorMessage = "An error occurred: \(error.localizedDescription)"
        }
        
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}


extension ViewController{
    
    //MARK: UI implement and constraint
    fileprivate func setUpUI()
    {
        
        // Top view constraint
        self.view.addSubview(topview)
        topview.translatesAutoresizingMaskIntoConstraints = false
        topview.topAnchor.constraint(equalTo: view.topAnchor, constant: topStatusHeight).isActive = true
        topview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        topview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        topview.heightAnchor.constraint(equalToConstant: 50).isActive = true
        topview.backgroundColor = UIColor.white
        
        // label text constraint
        self.topview.addSubview(lbltext)
        lbltext.translatesAutoresizingMaskIntoConstraints = false
        lbltext.leadingAnchor.constraint(equalTo: topview.leadingAnchor, constant: 0).isActive = true
        lbltext.topAnchor.constraint(equalTo: topview.topAnchor, constant: 0).isActive = true
        lbltext.bottomAnchor.constraint(equalTo: topview.bottomAnchor, constant: 0).isActive = true
        lbltext.trailingAnchor.constraint(equalTo: topview.trailingAnchor, constant: 0).isActive = true
        
        // Collection view constraint
        self.view.addSubview(collectionview)
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        collectionview.topAnchor.constraint(equalTo: topview.bottomAnchor, constant: 0).isActive = true
        collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        collectionview.alwaysBounceVertical = true
        
        
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return viewModel.resourceCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: resuseidentifier, for: indexPath) as! TopicsCollectionViewCell
        
        let resource = viewModel.resources[indexPath.item]
        cell.configCell(resource.imageURL, text: resource.title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth/2 - 15 , height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let resource = viewModel.resources[indexPath.item]
        navigateToNextScreen(with: resource)
    }
    
    // Navigation to SectionViewController
    func navigateToNextScreen(with resource: Resource) {
        let vc = SectionViewController()
        if let id = Int(resource.id) {
            vc.topicID = id
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

