//
//  detailsTableViewCell.swift
//  ShowsTV
//
//  Created by Infinum  on 28.07.2021..
//


import UIKit

final class detailsTableViewCell: UITableViewCell {

    // MARK: - Private UI

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var showImage: UILabel!
//    @IBOutlet private weak var : UILabel!
//    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
    }

}

// MARK: - Configure

extension detailsTableViewCell {

    func configure(with item: Show) {
    }
}

// MARK: - Private

private extension detailsTableViewCell {

    func setupUI() {
    }
}
