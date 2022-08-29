//
//  AKBannerCollectionView.swift
//  E_Learning
//
//  Created by Aiken on 2022/8/11.
//

import UIKit

 
public class AKBannerCollectionView: UICollectionView {

    var isTouching: Bool = false
     
    

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        super.touchesBegan(touches, with: event)
        isTouching = true
        print("touchesBegan: \(isTouching)")
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        isTouching = true
        
        print("touchesMoved: \(isTouching)")
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        isTouching = false
        
        print("touchesEnded: \(isTouching)")
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        isTouching = false
        
        print("touchesCancelled: \(isTouching)")
    }
    

}
