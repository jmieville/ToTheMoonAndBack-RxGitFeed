//
//  ViewController.swift
//  RxGitFeed
//
//  Created by Jean-Marc Kampol Mieville on 4/13/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ActivityController: UITableViewController {
    
    let repo = "ReactiveX/RxSwift"
    
    fileprivate let events = Variable<[Event]>([])
    fileprivate let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = repo
        
        self.refreshControl = UIRefreshControl()
        let refreshControl = self.refreshControl!
        
        refreshControl.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        refreshControl.tintColor = UIColor.darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        refresh()
    }
    
    func refresh() {
        fetchEvents(repo: repo)
    }
    
    func fetchEvents(repo: String) {
        
    }
    
    // MARK: - Table Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events.value[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = event.repo + ", " + event.action.replacingOccurrences(of: "Event", with: "").lowercased()
        cell.imageView?.kf.setImage(with: event.imageUrl, placeholder: UIImage(named: "blank-avatar"))
        return cell
    }
}
