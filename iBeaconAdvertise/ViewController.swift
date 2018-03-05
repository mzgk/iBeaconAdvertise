//
//  ViewController.swift
//  iBeaconAdvertise
//
//  Created by mzgk on 2018/03/05.
//  Copyright © 2018年 mzgk. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralManagerDelegate {

    // MARK: - アウトレット
    @IBOutlet weak var uuidValue: UILabel!
    @IBOutlet weak var majorValue: UILabel!
    @IBOutlet weak var minorValue: UILabel!

    // MARK: - プロパティ
    // Macコマンド：uuidgenで生成できる
    let UUID_VALUE = "92CEC608-0C60-4DCD-98C4-8EF57C09EBDE"
    let MAJOR_VALUE: CLBeaconMajorValue = 1
    let MINOR_VALUE: CLBeaconMinorValue = 1
    let IDENTIFIER_VALUE = "com.mzgkworks"

    let peripheralManager = CBPeripheralManager()
    var advertiseData = NSDictionary()
    var isAdvertising = false

    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        uuidValue.text = UUID_VALUE
        majorValue.text = String(MAJOR_VALUE)
        minorValue.text = String(MINOR_VALUE)

        peripheralManager.delegate = self

        // アドバタイズするデータを作成
        let uuid = UUID(uuidString: UUID_VALUE)
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!,
                                          major: MAJOR_VALUE,
                                          minor: MINOR_VALUE,
                                          identifier: IDENTIFIER_VALUE)
        advertiseData = NSDictionary(dictionary: beaconRegion.peripheralData(withMeasuredPower: nil))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - ユーザーイベント
    @IBAction func advertiseButtonTapped(_ sender: UIButton) {
        if isAdvertising {
            peripheralManager.stopAdvertising()
            sender.setTitle("Advertising", for: .normal)
            sender.backgroundColor = UIColor.orange
        } else {
            peripheralManager.startAdvertising(advertiseData as? [String: Any])
            sender.setTitle("Stop", for: .normal)
            sender.backgroundColor = UIColor.red
        }

        isAdvertising = !isAdvertising
    }

    // MARK: - CBPeripheralManagerDelegate
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("peripheralManagerDidUpdateState")
    }

    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("peripheralManagerDidStartAdvertising")
    }
}

