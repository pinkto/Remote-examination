//
//  ExamViewCell.swift
//  Remote examination
//
//  Created by Anna Abdeeva on 22.03.2022.
//

import UIKit

final class ExamViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timeStartLabel: UILabel!
    @IBOutlet var arrowMarkButton: UIButton!
    
    func configure(with model: ExamViewCellViewModel) {
        titleLabel.text = model.title
        scoreLabel.text = "Баллы: \(model.score)"
        timeStartLabel.text = model.timeStart
    }
}

struct ExamViewCellViewModel {
    let title: String
    let score: Int
    let timeStart: String
}
