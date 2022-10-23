//
//  ShareImageManager.swift
//  BoxOffice
//
//  Created by sole on 2022/10/23.
//

import UIKit

enum ShareContentManager {
    static func shanpshot(_ view: UIScrollView) throws -> UIImage {
        UIGraphicsBeginImageContext(view.contentSize)
        let savedContentOffset = view.contentOffset
        let savedFrame = view.frame
        view.contentOffset = CGPoint.zero
        view.frame = CGRect(x: 0,
                            y: 0,
                            width: view.contentSize.width,
                            height: view.contentSize.height)
        guard let context = UIGraphicsGetCurrentContext() else {
            print(ShareContentError.failToLoadContent.localizedDescription)
            throw ShareContentError.failToLoadContent
        }
        view.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            print(ShareContentError.failToRendering)
            throw ShareContentError.failToRendering
        }
        view.contentOffset = savedContentOffset
        view.frame = savedFrame
        UIGraphicsEndImageContext()
        return image
    }
}
