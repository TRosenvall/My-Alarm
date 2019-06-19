//
//  AlarmDetailTableViewController.swift
//  My Alarm
//
//  Created by Timothy Rosenvall on 6/17/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    @IBOutlet weak var datePickerLabel: UIDatePicker!
    @IBOutlet weak var textFieldLabel: UITextField!
    @IBOutlet weak var buttonTextLabel: UIButton!
    
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    var alarmIsOn: Bool {
        get {
            guard let alarmEnabled = alarm?.enabled else {return true}
            return alarmEnabled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func enableButtonTapped(_ sender: Any) {
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = textFieldLabel.text else {return}
        if let alarm = alarm {
            AlarmController.sharedInstance.updateAlarm(alarm: alarm, fireDate: datePickerLabel.date, name: name, enabled: alarm.enabled)
        } else {
            AlarmController.sharedInstance.addAlarm(fireDate: datePickerLabel.date, name: name, enabled: true)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    private func updateViews() {
        guard let alarm = alarm else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = dateFormatter.date(from: alarm.fireTimeAsString) else {return}
        datePickerLabel.date = date
        textFieldLabel.text = alarm.name
        buttonTextLabel.setTitle("On", for: .normal)
        if alarm.enabled {
            buttonTextLabel.setTitle("On", for: .normal)
        } else {
            buttonTextLabel.setTitle("Off", for: .disabled)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
