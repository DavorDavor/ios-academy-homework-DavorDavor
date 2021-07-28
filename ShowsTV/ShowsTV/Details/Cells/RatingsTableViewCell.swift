//
//  RatingsTableViewCell.swift
//  ShowsTV
//
//  Created by Infinum  on 28.07.2021..
//


import UIKit

final class ratingsTableViewCell: UITableViewCell {

    // MARK: - Private UI

    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

// MARK: - Configure

extension ratingsTableViewCell {

    func configure(with item: Show) {
        titleLabel.text = item.title
    }
}

// MARK: - Private

private extension ratingsTableViewCell {

    func setupUI() {
    }
}
