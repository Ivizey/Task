import UIKit


let fullString = NSMutableAttributedString(string: "Your rank: ")
let image1Attachment = NSTextAttachment()
image1Attachment.image = UIImage(systemName: "plus")
let image1String = NSAttributedString(attachment: image1Attachment)
fullString.append(image1String)
print(fullString)

class Person {
    private var age: Int = 10
    func setAge(age: Int) {
        self.age = age
    }
}

let person = Person()
person.setAge(age: 20)
