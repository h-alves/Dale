//
//  DaleApp.swift
//  Dale
//
//  Created by Henrique Semmer on 24/08/23.
//

import SwiftUI

@main
struct DaleApp: App {
    @AppStorage("hasAppearedBefore") private var hasAppearedBefore = false
    @State var load = false
    
    var body: some Scene {
        WindowGroup {
            
            if(!load){
                SplashView(isEnd: $load)
            }
            else if (!hasAppearedBefore){
                OnBoardingView()
            }
            else{
                ContentView()
                    .preferredColorScheme(.dark)
            }
            
                
        }
        
    }
}
