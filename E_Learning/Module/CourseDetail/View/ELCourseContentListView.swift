//
//  ELCourseContentListView.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/29.
//

import UIKit
import SwiftyFitsize

private let SummaryCell = "SummaryCell"
private let CellID = "CellID"

class ELCourseContentListView: ELBasicView {
    
    var count = 0

    var headerView: ELCourseContentHeaderView!
    private let tableView = UITableView(frame: .zero, style: .plain).then() {
        $0.separatorStyle = UITableViewCell.SeparatorStyle.none
        $0.backgroundColor = .clear
        $0.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
        $0.register(ELCourseSummaryTableViewCell.self, forCellReuseIdentifier: SummaryCell)
        $0.isScrollEnabled = false
        $0.estimatedRowHeight = 0
        $0.estimatedSectionFooterHeight = 0
        $0.estimatedSectionHeaderHeight = 0
        $0.addDefaultCorner()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        headerView = ELCourseContentHeaderView(frame: .zero, leftClosure: { [weak self] in
            self?.tableView.isScrollEnabled = true
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: true)
        }, middleClosure: { [weak self] in
            self?.tableView.isScrollEnabled = true
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .none, animated: true)
        }, rightClosure: { [weak self] in
            self?.tableView.isScrollEnabled = true
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: .none, animated: true)
        })
        headerView.addDefaultCorner()
        addSubview(headerView)
        
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
    }
    
    private func layout() {
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(43.5∥)
        }
        
        tableView.snp.makeConstraints { make in
            make.height.equalTo(0)
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    func refreshData() {
        count = 2
        tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.tableView.snp.updateConstraints { make in
                make.height.equalTo(self.tableView.contentSize.height)
            }
        }
    }
}

extension ELCourseContentListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollToScrollStop = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
        
        if scrollToScrollStop {
            self.scrollViewDidEndScroll()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let dragToDragStop = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
        if dragToDragStop {
            self.scrollViewDidEndScroll()
        }
    }
    
    /** 停止滚动 */
    func scrollViewDidEndScroll() {
        tableView.isScrollEnabled = false
    }
}

extension ELCourseContentListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//        default:
//            return count
//        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewW = tableView.width
        if tableViewW > 0 {
            return tableView.fd_heightForCell(withIdentifier: SummaryCell) { cell in
                
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.section {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCell, for: indexPath) as! ELCourseSummaryTableViewCell
//            return cell
//        default:
//            let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath)
//            cell.selectionStyle = .none
//            cell.backgroundColor = .blue
//            return cell
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCell, for: indexPath) as! ELCourseSummaryTableViewCell
        return cell
    }
}

