//
//  OnBoardingView.swift
//  Dale
//
//  Created by Robson Borges on 13/09/23.
//

import SwiftUI

struct OnBoardingView: View {
    @State var next = false
    @AppStorage("hasAppearedBefore") private var hasAppearedBefore = false
    
    var body: some View {
        VStack{
            VStack{
                
                
                Image("bv")
                    .resizable()
                    .scaledToFit()
                    .padding(.top,100)
                
                
                VStack{
                    Spacer()
                    // bloquinho 01
                    VStack{
                        HStack{
                            Image("meiuca")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 35)
                            
                            VStack{
                                HStack{
                                    Text("Marque")
                                        .foregroundColor(.white)
                                        .font(.system(size: 17))
                                    Text("pontos")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.system(size: 17))
                                    Spacer()
                                }
                                HStack{
                                    Text("conforme")
                                        .foregroundColor(.white)
                                        .font(.system(size: 17))
                                    Text(" seu interesse")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.system(size: 17))
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(16)
                    
                    //Bloquinho 02
                    VStack{
                        HStack{
                            Image("meiuca")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 35)
                            
                            VStack{
                                HStack{
                                    Text("Encontre")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.system(size: 17))
                                    Text("facilmente seus")
                                        .foregroundColor(.white)
                                        .font(.system(size: 17))
                                    Spacer()
                                }
                                HStack{
                                    Text("pontos")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.system(size: 17))
                                    Text("marcados")
                                        .foregroundColor(.white)
                                        .font(.system(size: 17))
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(16)
                    
                    // Bloquinho 03
                    VStack{
                        HStack{
                            Image("meiuca")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 35)
                            
                            VStack{
                                HStack{
                                    Text("Confira seus últimas\nmarcações na página de\nhistórico")
                                        .font(.system(size: 17))
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(16)
                    
                    Spacer()
                    
                    Button(action:{
                        next.toggle()
                        hasAppearedBefore = true
                    }){
                        Text("Começar")
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(Color("MagentaMarrenta"))
                            .cornerRadius(16)
                            .font(.system(size: 21,weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .fullScreenCover(isPresented: $next){
                        ContentView()
                    }
                }
                .padding(16)
                
            }
            .padding(16)
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color("RoxoBG"))
        
        
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
