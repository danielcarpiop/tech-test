import UIKit

class ArtistBaseViewController: UIViewController {
    let tableView = UITableView()
    let headerTable = HeaderInfoView()
    let useCase = ArtistListUseCase(service: ArtistListApi())
    var artistViewModels: [ViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
    }
    
    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArtistGlobalInfoCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = UIColor.purple
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerTable)
        headerTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            headerTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerTable.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func navigateToDetail(viewModel: ViewModel) {
        navigationController?.present(ArtistDetailIViewController(viewModel: viewModel), animated: true)
    }
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
}

extension ArtistBaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ArtistGlobalInfoCell else {
            fatalError("Unable to dequeue ArtistGlobalInfoCell")
        }
        let viewModel = artistViewModels[indexPath.row]
        cell.configure(title: viewModel.name, subtitle: viewModel.releaseDate, imgURL: viewModel.imageUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedViewModel = artistViewModels[indexPath.row]
        let detailViewController = ArtistDetailIViewController(viewModel: selectedViewModel)
        detailViewController.modalPresentationStyle = .overFullScreen
        detailViewController.modalTransitionStyle = .crossDissolve
        navigationController?.present(detailViewController, animated: false)
    }
}

