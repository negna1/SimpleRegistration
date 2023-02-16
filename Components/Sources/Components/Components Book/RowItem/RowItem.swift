//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import UIKit
import SnapKit
import SDWebImage

public class RowItem: UIView {
    private let leftIcon: UIImageView = {
        let leftIcon = UIImageView()
        leftIcon.isHidden = true
        leftIcon.contentMode = .scaleAspectFill
        
        leftIcon.tintColor = .black
        leftIcon.translatesAutoresizingMaskIntoConstraints = false
        return leftIcon
    }()
    
    private let rightIcon: UIImageView = {
        let rightIcon = UIImageView()
        rightIcon.isHidden = true
        rightIcon.contentMode = .scaleAspectFit
        rightIcon.translatesAutoresizingMaskIntoConstraints = false
        return rightIcon
    }()
    
    private let leftLabel: UILabel = {
        let labels = UILabel()
        labels.isHidden = true
        labels.translatesAutoresizingMaskIntoConstraints = false
        return labels
    }()
    
    private let rightLabel: UILabel = {
        let labels = UILabel()
        labels.isHidden = true
        labels.translatesAutoresizingMaskIntoConstraints = false
        return labels
    }()
    
    private let firstLabel: UILabel = {
        let labels = UILabel()
        labels.translatesAutoresizingMaskIntoConstraints = false
        return labels
    }()
    
    private let secondLabel: UILabel = {
        let labels = UILabel()
        labels.isHidden = true
        labels.translatesAutoresizingMaskIntoConstraints = false
        return labels
    }()
    
    private let thirdLabel: UILabel = {
        let labels = UILabel()
        labels.isHidden = true
        labels.translatesAutoresizingMaskIntoConstraints = false
        return labels
    }()
    
    private lazy var labelsStack: UIStackView = {
        let labels = UIStackView()
        labels.addArrangedSubview(firstLabel)
        labels.addArrangedSubview(secondLabel)
        labels.addArrangedSubview(thirdLabel)
        labels.axis = .vertical
        labels.translatesAutoresizingMaskIntoConstraints = false
        return labels
    }()
    
    public lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(leftStack)
        stack.addArrangedSubview(labelsStack)
        stack.addArrangedSubview(rightStack)
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var leftStack: UIStackView = {
        let stack = UIStackView()
        stack.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(100)
        }
        stack.isHidden = true
        stack.addArrangedSubview(leftLabel)
        stack.addArrangedSubview(leftIcon)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var rightStack: UIStackView = {
        let stack = UIStackView()
        stack.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(100)
        }
        stack.isHidden = true
        stack.addArrangedSubview(rightIcon)
        stack.addArrangedSubview(rightLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    public init() {
        super.init(frame: .zero)
        setupStyle()
        setUp()
    }
    
    convenience init(model: RowItem.ViewModel) {
        self.init()
        self.configure(with: model)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -SetUp

extension RowItem {
    
    func setupStyle() {
        backgroundColor = .white
    }
    
    func setUp() {
        addSubview(containerStack)
        addSubview(separatorView)
        configureStackConstraints()
        configureSeparatorViewConsraints()
    }
    
    
    func configureStackConstraints() {
        containerStack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().offset(6)
        }
    }
    
    func configureSeparatorViewConsraints() {
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(6)
            make.top.equalTo(leftIcon.snp.bottom).offset(7)
            make.height.equalTo(2)
           // make.bottom.equalToSuperview()
        }
    }
}

// MARK: -Configure

public extension RowItem {
    
    func configure(with model: RowItem.ViewModel) {
        separatorView.isHidden = !model.needSeparator
        configure(labels: model.labels)
        configure(rightType: model.right)
        configure(leftType: model.left)
    }
    
    private func configure(labels: LabelType) {
        switch labels {
        case .oneLine(let rowElementParam):
            firstLabel.changeLabel(with: rowElementParam)
        case .twoLine(let rowElementParam, let rowElementParam2):
            firstLabel.changeLabel(with: rowElementParam)
            secondLabel.changeLabel(with: rowElementParam2)
            secondLabel.isHidden = false
        case .threeLine(let rowElementParam, let rowElementParam2, let rowElementParam3):
            firstLabel.changeLabel(with: rowElementParam)
            secondLabel.changeLabel(with: rowElementParam2)
            thirdLabel.changeLabel(with: rowElementParam3)
            secondLabel.isHidden = false
            thirdLabel.isHidden = false
        }
    }
    
    private func configure(rightType: ElementType?) {
        guard let rightType = rightType else {
            rightStack.isHidden = true
            return
        }
        rightStack.isHidden = false
        switch rightType {
        case .title(let rowElementParam):
            rightLabel.changeLabel(with: rowElementParam)
            rightLabel.isHidden = false
        case .image(let uIImage, let width):
            rightIcon.snp.makeConstraints { make in
                make.width.height.equalTo(width)
            }
            rightIcon.image = uIImage
            rightIcon.isHidden = false
        case .remoteImage(let url, let width):
            rightIcon.snp.makeConstraints { make in
                make.width.height.equalTo(width)
            }
            rightIcon.sd_setImage(with: url)
            rightIcon.isHidden = false
        }
    }
    
    private func configure(leftType: ElementType?) {
        guard let leftType = leftType else {
            leftStack.isHidden = true
            return
        }
        leftStack.isHidden = false
        switch leftType {
        case .title(let rowElementParam):
            leftLabel.changeLabel(with: rowElementParam)
            leftLabel.isHidden = false
        case .image(let uIImage, let width):
            leftIcon.snp.makeConstraints { make in
                make.width.height.equalTo(width)
            }
            leftIcon.image = uIImage
            leftIcon.isHidden = false
        case .remoteImage(let url, let width):
            leftIcon.snp.makeConstraints { make in
                make.width.height.equalTo(width)
            }
            DispatchQueue.main.async {
                self.leftIcon.sd_setImage(with: url)
            }
            leftIcon.layer.cornerRadius = width/2
            leftIcon.layer.masksToBounds = true
            leftIcon.isHidden = false
        }
    }
}


extension UILabel {
    func changeLabel(with param: RowItem.RowElementParam) {
        self.text = param.title
        self.font = param.font
        self.textColor = param.color
    }
}
