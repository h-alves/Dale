//
//  BottomBarView.swift
//  Dale
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI
import CoreLocation

struct BottomBarView: View {
    @Binding var annotation: Place
    @Binding var state: Modo
    
    @Binding var nome: String
    @Binding var descricao: String
    @Binding var categoria: Categoria
    
    @State var mainFunction: () -> Void
    
    var body: some View{
        VStack{
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 40, height: 5)
                .foregroundColor(Color(UIColor.systemGray2))
            
            switch state{
            case .creating:
                creatingView
            case .clicking:
                clickingView
            case.editing:
                editingView
            case.none:
                defaultView
            }
            
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 5)
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .background(.white)
    }
    
    var creatingView: some View {
        VStack{
            Button {
                mainFunction()
            } label: {
                Text("teste")
            }

        }
    }
    
    var clickingView: some View {
        VStack(spacing: 36){
            HStack{
                VStack(alignment: .leading){
                    Text(annotation.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.indigo)
                    Text(annotation.descricao)
                        .foregroundColor(.indigo)
                }
                
                Spacer()
                
                Button {
                    // Função de editar
                    mainFunction()
                } label: {
                    Text("Editar")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(8)
                }
            }
            HStack{
                CategoryButton(categoria: annotation.categoria)
                
                Spacer()
            }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 12)
    }
    
    var editingView: some View {
        VStack{
            VStack{
                CaixaTexto(textoCaixa: "Nome", texto: $nome)
                
                CaixaTexto(textoCaixa: "Descrição", texto: $descricao)
                
                FlexStack{
                    ForEach(Categoria.getAll()){ categoria in
                        Button {
                            // Feedback (Deixar todos os outros cinza e esse completo)
                            self.categoria = categoria
                        } label: {
                            CategoryButton(categoria: categoria)
                        }
                    }
                }
            }
            
            Spacer()
            
            Button {
                // Desabilitar botão quando não marcou tudo
                mainFunction()
            } label: {
                Text("ADICIONAR MARCADOR")
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(12)
            }

            Spacer()
        }
    }
    
    var defaultView: some View {
        VStack{
            
        }
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(annotation: .constant(Place(name: "teste", descricao: "teste 2", categoria: Categoria.buraco, coordinate: CLLocationCoordinate2D(latitude: 12, longitude: 12), state: .none)), state: .constant(.none), nome: .constant(""), descricao: .constant(""), categoria: .constant(Categoria.vazia)){
            print("a")
        }
    }
}
