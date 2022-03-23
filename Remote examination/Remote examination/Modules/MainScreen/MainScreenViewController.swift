//
//  MainScreenViewController.swift
//  Remote examination
//
//  Created by Anna Abdeeva on 22.03.2022.
//

import Foundation
import UIKit
import Moya

class MainScreenViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var exitButton: UIButton!
    @IBOutlet var examsTypeSegmentedControl: UISegmentedControl!
    
    private var studentExams: [ExamViewCellViewModel] = []
    var token = "" {
        didSet {
            performGetTicketRequest(token: token)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didReceiveToken(_:)),
            name: Notification.Name("didReceiveToken"),
            object: nil
        )
    }
}

// MARK: - View configuration

private extension MainScreenViewController {
    func configureView() {
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "ExamViewCell", bundle: nil), forCellReuseIdentifier: "cell"
        )
    }
    
    func performGetTicketRequest(token: String) -> Void {
        let target = ExamsAPITarget(
            endpoint: .production,
            route: .ticket(token)
        )
        
        let provider = MoyaProvider<ExamsAPITarget>()
        
        provider.request(target) { [weak self] result in
            switch result {
            case let .success(response):
                guard let exams = try? response.map([StudentExam].self) else {
                    print("Леееее слушай не видишь badDecoding идёт")
                    return
                }
                self?.studentExams = exams.map {
                    ExamViewCellViewModel(
                        title: $0.examPeriod.exam.discipline.name,
                        score: $0.semesterRating,
                        timeStart: $0.examPeriod.start
                    )
                }
                self?.tableView.reloadData()
                
            case .failure:
                print("Леееее слушай не видишь рандомная ошибка идёт")
            }
        }
    }
    
    @objc
    func didReceiveToken(_ notification: Notification) {
        guard let token = notification.object as? String else {
            return
        }
        
        self.token = token
    }
}

// MARK: - MainScreenViewController

extension MainScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        studentExams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExamViewCell
        cell.configure(with: studentExams[indexPath.row])
        return cell
    }
}
