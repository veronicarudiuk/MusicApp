//
//  TabCell.swift
//  MusicApp
//
//  Created by vas on 16.01.2023.
//

import UIKit

class TabCell: UICollectionViewCell {
  private var tabSV: UIStackView!

  var tabTitle: UILabel!
  var indicatorView: UIView!
  var indicatorColor: UIColor = .green

  override var isSelected: Bool {
    didSet {
      DispatchQueue.main.async {
        UIView.animate(withDuration: 0.2) {
          self.indicatorView.backgroundColor = self.isSelected ? self.indicatorColor : UIColor.clear
          self.tabTitle.textColor = self.isSelected ? .green : .white
          self.layoutIfNeeded()
        }
      }
    }
  }

  var tabViewModel: Tab? {
    didSet {
      tabTitle.text = tabViewModel?.title

    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    tabSV = UIStackView()
    tabSV.axis = .horizontal
    tabSV.distribution = .equalCentering
    tabSV.alignment = .center
    tabSV.spacing = 10.0
    addSubview(tabSV)


    // Tab Title
    tabTitle = UILabel()
    tabTitle.textAlignment = .center
    self.tabSV.addArrangedSubview(tabTitle)



    // TabSv Constraints
    tabSV.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tabSV.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      tabSV.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])

    setupIndicatorView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    tabTitle.text = ""
  }

  func setupIndicatorView() {
    indicatorView = UIView()
    addSubview(indicatorView)

    let indicatorWidth = indicatorView.widthAnchor.constraint(equalTo: tabTitle.widthAnchor, multiplier: 0.9)
    indicatorWidth.constant = tabTitle.intrinsicContentSize.width

    indicatorView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      indicatorView.heightAnchor.constraint(equalToConstant: 2),
      indicatorWidth,
      indicatorView.centerXAnchor.constraint(equalTo: tabTitle.centerXAnchor),
      indicatorView.bottomAnchor.constraint(equalTo: self.tabTitle.bottomAnchor, constant: 10)
    ])
  }
}

