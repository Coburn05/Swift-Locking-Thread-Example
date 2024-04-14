import UIKit

class BankAccount {
    
    var balance: Double
    let lock = NSLock()
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func withdraw(_ amount: Double) {
        print("[WITHDRAW] attempt for $\(amount)")
        lock.lock()
        if balance >= amount {
            let processingTime = UInt32.random(in: 0...3)
            print("[WITHDRAW] processing for $\(amount) \(processingTime) seconds")
            sleep(processingTime)
            print("[WITHDRAW] $\(amount) from balance")
            balance -= amount
            print("balance now is $\(balance)")
        } else {
            print("[WITHDRAW] failed to withdraw \(amount)")
        }
        lock.unlock()
    }
}

let bankAccount = BankAccount(balance: 500)

Task.detached {
    bankAccount.withdraw(300)
}
Task.detached {
    bankAccount.withdraw(500)
}
