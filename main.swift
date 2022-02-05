//Create Date 05-02-2022
//64130010049 ปริญญา เติมกสิพาณิชย์

import Foundation

let config_package_name:[Int:String] = [
  1:"dtac GO 399",
  2:"dtac GO 499",
  3:"dtac GO 599",
  4:"dtac GO 699",
  5:"dtac GO 899",
  6:"dtac GO 1099 internet unlimited",
  7:"dtac GO 1499 internet unlimited",
  8:"dtac GO 1999 internet unlimited",
  9:"dtac GO 2199 internet unlimited",
  10:"No Package"
]
let config_package_price:[Int:Float] = [
  1:399.0,
  2:499.0,
  3:599.0,
  4:699.0,
  5:899.0,
  6:1099.0,
  7:1499.0,
  8:1999.0,
  9:2199.0,
  10:0.0
]
let config_package_callLimit:[Int:Int] = [
  1:150,
  2:200,
  3:300,
  4:300,
  5:400,
  6:700,
  7:1200,
  8:2500,
  9:0,
  10:0
]
let config_package_unlimited:[Int] = [9]

var display_package:String = ""

var package:Int = 0
var call:[String:Int] = ["second":0,"minute":0,"inpackage":0,"extra":0]
var sms:Int = 0

var call_extra_price:Float = 0.0
var sms_price:Float = 0.0

var subtotal:Float = 0.0
var vat:Float = 0.0
var total:Float = 0.0
//input
for index in 1...config_package_name.count {
  display_package += "\(config_package_name[index]!) Enter \(index) \n"
}
repeat {
  print(display_package)
  print("Select Package (1-\(config_package_name.count)) : ", terminator: "")
  package = Int(readLine()!)!
} while config_package_name[package] == nil

repeat {
  print("Enter Call Usage (Second) : ", terminator: "")
  call["second"] = Int(readLine()!)!
} while call["second"]! < 0

repeat {
  print("Enter SMS Usage (Message) : ", terminator: "")
  sms = Int(readLine()!)!
} while sms < 0

//calculate call
call["minute"] = (call["second"]! / 60) + (call["second"]! % 60 == 0 ? 0 : 1)
if(call["minute"]! > config_package_callLimit[package]! && !config_package_unlimited.contains(package)){
  call["inpackage"] = config_package_callLimit[package]!
  call["extra"] = call["minute"]! - config_package_callLimit[package]!
}else{
  call["inpackage"] = call["minute"]!
  call["extra"] = 0
}
//calculate price
call_extra_price = Float(call["extra"]!) * 1.5
sms_price = Float(sms) * 3
//calculate payment detail
subtotal = config_package_price[package]! + call_extra_price + sms_price
vat = subtotal * 0.07
total = subtotal + vat
//output
print("""
------------Mobile Package------------
[Package Detail]
Package : \(config_package_name[package]!)
Price : \(config_package_price[package]!) Baht/Month

[Usage Detail]
Package Call : \(call["inpackage"]!) Minutes | 0 Baht
Extra Call (1.5 Baht/Minutes) : \(call["extra"]!) minutes | \(call_extra_price) Baht
SMS : \(sms) Message | \(sms_price) Baht

[Payment Detail]
Subtotal (Vat not included) : \(subtotal) Baht
Vat 7% : \(vat) Baht
Total (Vat included) : \(total) Baht
""")