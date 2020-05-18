//
//  KingfisherExtension.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(with url: URL) {
        self.kf.setImage(
            with: url,
            placeholder: #imageLiteral(resourceName: "image-placeholder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
    
}
