//
//  TextHeaderView.swift
//  BoxOffice
//
//  Created by sole on 2022/10/20.
//

import UIKit

final class TextHeaderView: UICollectionReusableView {
    static let nibName = "TextHeaderView"
    static let elementKind = "text-header"
    static let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
    static let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize, elementKind: elementKind, alignment: .top)
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        sectionTitleLabel.text = nil
    }
    
    func configure(title: String) {
        sectionTitleLabel.text = title
    }
    
    static func nib() -> UINib {
        return UINib(nibName: TextHeaderView.nibName, bundle: nil)
    }
}
