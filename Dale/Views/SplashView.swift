//
//  SplashView.swift
//  Dale
//
//  Created by Robson Borges on 13/09/23.
//

import SwiftUI

struct SplashView: View {
    @State private var isPulsing = false
    @Binding var isEnd : Bool
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100)
                .scaleEffect(isPulsing ? 1.2 : 1.0) // Varie a escala entre 1 e 1.2
                .animation(
                    Animation.easeInOut(duration: 1.0) // Ajuste a duração da animação conforme necessário
                        .repeatForever(autoreverses: true) // Faça a animação repetir indefinidamente
                )
                .onAppear() {
                    isPulsing.toggle() // Inicie a animação quando a vista aparecer
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        // Após um segundo, altere a variável booleana
                        self.isEnd = true
                        
                    }
                }
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color("RoxoBG"))
        
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        let boleano = false
        SplashView(isEnd: .constant(boleano))
    }
}
