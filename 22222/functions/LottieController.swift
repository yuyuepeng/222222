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
        // Do any additional setup after loading the view.
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
