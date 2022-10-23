//
//  RankingHeaderView.swift
//  BoxOffice
//
//  Created by sole on 2022/10/19.
//

import UIKit

final class RankingHeaderView: UICollectionReusableView {
    static let nibName = "RankingHeaderView"
    static let elementKind = "ranking-header"
    static let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
    static let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize, elementKind: elementKind, alignment: .top)
    
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedDate.text = Date().yesterday.converToStringTypeForUI
    }
    
    static func nib() -> UINib {
        return UINib(nibName: RankingHeaderView.nibName, bundle: nil)
    }
    
    @IBAction func didTapCalendarButton(_ sender: UIButton) {
        print("Calendar button tapped!")
        // TODO: - 선택된것처럼 보여지지 않음, 날짜전달
    }
}
