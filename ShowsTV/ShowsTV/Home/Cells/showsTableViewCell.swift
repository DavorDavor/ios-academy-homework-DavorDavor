
//  showsTableViewCell.swift
//  ShowsTV
//

import UIKit

final class showsTableViewCell: UITableViewCell {

    // MARK: - Private UI

    @IBOutlet private weak var titleLabel: UILabel!

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

extension showsTableViewCell {

    func configure(with item: Show) {
        titleLabel.text = item.title
    }
}

// MARK: - Private

private extension showsTableViewCell {

    func setupUI() {
    }
}
