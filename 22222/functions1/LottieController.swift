//
//  LottieController.swift
//  22222
//
//  Created by 玉岳鹏 on 2019/4/17.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

import UIKit
import Lottie
class LottieController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let startAnimationView = AnimationView.init(name: "ar_banner_2")
        startAnimationView.frame = self.view.bounds
        self.view .addSubview(startAnimationView)
        startAnimationView .play()
        startAnimationView.loopMode = LottieLoopMode.loop
        
        
        let addCloser1:(_ num1:Int, _ num2:Int) -> (Int)
        
        addCloser1 = {
            (_ num1:Int, _ num2:Int) -> (Int) in
            return num1 + num2
        }
        
        let result = addCloser1(10,23);
        
        print("\(result)");
        
         
        // Do any additional setup after loading the view.
    }
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
           }
        }
    class Solution {
        func reverseList(_ head: ListNode?) -> ListNode? {
            var fhead:ListNode = head!
            
            var newhead:ListNode?
            while (fhead != nil) {
                var tmp = fhead.next
                fhead.next = newhead
                newhead = head
                fhead = tmp!
            }
            return newhead
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
