//
//  ViewController.swift
//  ExNetworkFailed
//
//  Created by 강동영 on 4/14/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 경합을 일으킬 코드
        let trade = Trade()

        Task {
            var tradeVO = await trade.getTrade()
            print(Unmanaged.passUnretained(tradeVO).toOpaque(), "Fisrt unretained")

            print(address(&tradeVO), "first")
            for _ in 0..<10_000 {
                tradeVO.price += 1 // 💥 여기서 경합
            }
            print(tradeVO.price, "first")
        }

        Task {
            var tradeVO = await trade.getTrade()
            print(Unmanaged.passUnretained(tradeVO).toOpaque(), "second unretained")

            print(address(&tradeVO), "second")
            for _ in 0..<10_000 {
                tradeVO.price += 1 // 💥 동시에 접근
            }
            print(tradeVO.price, "second")
        }

    }


}

// 참조 타입
class CoinTradeVO {
    var price: Int
    init(price: Int) { self.price = price }
}

// actor 정의
actor Trade {
    private var trades: [CoinTradeVO] = [CoinTradeVO(price: 100)]

    func getTrade() -> CoinTradeVO {
        return trades[0] // 얕은 복사 (참조 노출)
    }
}



func address(_ o: UnsafeRawPointer) -> String {
    let bit = Int(bitPattern: o)
    return String(format: "%p", bit)
}
