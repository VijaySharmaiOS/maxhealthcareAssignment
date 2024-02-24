//
//  SectionViewController.swift
//  MaxHealthCare
//
//  Created by VJ on 22/02/24.
//

import UIKit
import KRProgressHUD

class SectionViewController: UIViewController {

    //MARK: VARIABLES
    var viewModel = TopicViewModel()
    var resuseidentifier = "TopicsTableViewCell"
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var topicID = Int()

    // MARK: UI COMPONENTS
    // Topview to display label
    private lazy var topview: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    // table view to display the topic title
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    
    internal var topStatusHeight : CGFloat{
        return 32
    }

    //MARK: ViewdidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        registercell()
        setScreenheightWidth()
        setUpUI()
        getTopics(topicid: topicID)
        view.backgroundColor = .white

    }

    // register tabel view
    func registercell(){
        tableView.register(SectionTableViewCell.self, forCellReuseIdentifier: resuseidentifier)
    }

    // get screen height and width
    func setScreenheightWidth(){
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
    }

    // Api call where we get the data with ID
    func getTopics(topicid: Int){
        viewModel.fetchData(withId: topicid) { [weak self] result in
            DispatchQueue.main.async {
                KRProgressHUD.dismiss()
                switch result {
                case .success:
                    self?.tableView.reloadData()
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

extension SectionViewController {
    
    //MARK: UI implement and constraint
    fileprivate func setUpUI() {

        // Top view constraint
        view.addSubview(topview)
        topview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topview.topAnchor.constraint(equalTo: view.topAnchor, constant: topStatusHeight),
            topview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topview.heightAnchor.constraint(equalToConstant: 50)
        ])

        // tableview view constraint
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant:  -10),
            tableView.topAnchor.constraint(equalTo: topview.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
    }
}

extension SectionViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.section.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: resuseidentifier, for: indexPath) as! SectionTableViewCell
        cell.label.text = viewModel.section[indexPath.row].title
        cell.selectionStyle = .none
        cell.labelContainerView.layer.cornerRadius = 10
        cell.labelContainerView.layer.borderWidth = 1.0
        cell.labelContainerView.layer.borderColor = UIColor.gray.cgColor
        cell.labelContainerView.layer.masksToBounds = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedtext = viewModel.section[indexPath.row].content
       navtoDetailsViewController(selectedtextconetnt: selectedtext)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // Navigation to DetailsViewController
    func navtoDetailsViewController(selectedtextconetnt : String){
        let vc = DetailsViewController()
        vc.selectedContent = selectedtextconetnt
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
