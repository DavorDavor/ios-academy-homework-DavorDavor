
//  showsTableViewCell.swift
//  ShowsTV
//

import UIKit
import Kingfisher

final class showsTableViewCell: UITableViewCell {

    // MARK: - Private UI

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var showImageView: UIImageView!

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

    func configure(with show: Show) {
        titleLabel.text = show.title
        guard let imageUrl = show.imageUrl else { return }
        guard let imageUrl = URL(string: imageUrl) else {return}
        showImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "ic-show-placeholder-vertical"))
    }
}

// MARK: - Private

private extension showsTableViewCell {

    func setupUI() {
    }
}
