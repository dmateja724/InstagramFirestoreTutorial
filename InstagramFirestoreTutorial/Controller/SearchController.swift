//
//  SearchController.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 11/22/21.
//

import UIKit

private let postCellIdentifier = "ProfileCell"

private let reuseIdentifier = "UserCell"

class SearchController: UIViewController {
    // MARK: - Properties

    private let tableView = UITableView()
    private var users = [User]()
    private var filteredUsers = [User]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var posts = [Post]()
    private var inSearchMode: Bool {
        searchController.isActive && !searchController.searchBar.text!.isEmpty
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(ProfileCell.self, forCellWithReuseIdentifier: postCellIdentifier)
        return cv
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
        configureSearchController()
        fetchPosts()
    }

    // MARK: - Helpers

    func configureUI() {
        navigationItem.title = "Explore"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.isHidden = true
        
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }

    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }

    // MARK: - API

    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    func fetchPosts() {
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        inSearchMode ? filteredUsers.count : users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension SearchController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        collectionView.isHidden = true
        tableView.isHidden = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = nil
        
        collectionView.isHidden = false
        tableView.isHidden = true
    }
}

// MARK: - UISearchResultsUpdating

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }

        filteredUsers = users.filter {
            $0.username.contains(searchText) ||
                $0.fullname.lowercased().contains(searchText)
        }

        tableView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension SearchController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellIdentifier, for: indexPath) as! ProfileCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension SearchController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        1
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        1
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
}
