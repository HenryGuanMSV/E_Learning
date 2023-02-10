//
//  ELCourseViewController.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/14.
//

import UIKit

class ELCourseViewController: ELBasicViewController{

    
    @IBOutlet weak var typeNameTab: UITableView!
    @IBOutlet weak var typeDataTab: UITableView!
    let typeNameArr = ["Hot","Front-End","Back-End","Mobile","Big Data","Database","English Email","User Experience"]
    let typeDataArr = [
        [["typeName" : "Hot", "typeDate" : ["Java","Robot","Go","Python","Html 5","Robot"]]],
        [["typeName" : "Front-End", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
        [["typeName" : "Back-End", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
        [["typeName" : "Android", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]],
        ["typeName" : "iOS", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
        [["typeName" : "Big Data", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
        [["typeName" : "Database", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
        [["typeName" : "English Email", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
        [["typeName" : "User Experience", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
        
    ]
    var courseModel : dataModel?
    var selectNumber = 0
    var infoCount    = 0
    var infoData  : [[[String]]] = []
    // MARK: 销毁
    deinit {
        print("销毁ELCourseViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        typeNameTab.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        typeDataTab.separatorColor = UIColor.whiteColor
        typeNameTab.separatorColor = UIColor.whiteColor
        // 解析数据
        parseData()
        layout()
        binding()
    }
    
    func parseData() {
        infoData = []
        courseModel = dataModel()
        courseModel?.list = []
        for i in 0...typeDataArr.count - 1 {
            
            var infoModel = listModel()
            var infoarr : [listModel] = []
            for infodata in typeDataArr[i]{
                infoModel.typeName = infodata["typeName"] as? String
                infoModel.typeDate = infodata["typeDate"] as? [String]
                infoarr.append(infoModel)
            }
            courseModel?.list.append(infoarr)
        }
        
        getInfoDataList()
    }
    
    func getInfoDataList()  {
        // 格式化 详情数据
        let arr = courseModel?.list[selectNumber] ?? []
        infoData = []
        var count = 0
        for item in arr {
            // 每种Type的数据类型
            var datalist : [[String]] = []
            var newArr : [String] = []
            var group = 0
            for info in item.typeDate! {
                newArr.append(info)
                if group == 2{
                    group = 0
                    datalist.append(newArr)
                    newArr = []
                    count += 1
                    continue
                }else  if ((item.typeDate?.count ?? 0) - 1 < 2 && item.typeDate?.count == group - 1) {
                    datalist.append(newArr)
                    count += 1
                }
                group += 1
            }
            infoData.append(datalist)
        }
        
        // 获取每组 详细数据个数
        infoCount = count
        typeDataTab.reloadData()
    }
    /** 视图即将出现 */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .blue
        
    }

    /** 视图即将移除 */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
        
    private func layout() {
        
    }
    
    private func binding() {
        view.backgroundColor = .black
    }


}

// MARK -- UITableViewDelegate And UITableViewDataSource
extension ELCourseViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == typeNameTab {
            
        } else {
            return courseModel?.list[selectNumber][section].typeName
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView == typeNameTab ? 64 : 140
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableView == typeNameTab ? 1 : infoData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == typeNameTab {
            return typeNameArr.count
        } else {
            return infoData[section].count
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == typeNameTab {
            return 0
        }else {
            return 64
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == typeNameTab {
            let cell = tableView.dequeueReusableCell(withIdentifier:"TypeName" ) as? MenuListNameCell
            cell?.CreatUI(titleText: typeNameArr[indexPath.row])
            cell?.backgroundColor = selectNumber == indexPath.row ?  UIColor(red: 241, green: 244, blue: 245, alpha: 1) : UIColor.white
            return cell ?? UITableViewCell()
        }else if tableView == typeDataTab {

            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeData") as? MenuDataListCell
            cell?.CreatUI(infoData: infoData[indexPath.section][indexPath.row])
            return cell ?? UITableViewCell()
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == typeNameTab {
            
            selectNumber = indexPath.row
            tableView.reloadData()
            getInfoDataList()
        }
    }
    
    
    
}
