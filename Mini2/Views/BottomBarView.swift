//
//  BottomBarView.swift
//  Mini2
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI
import CoreLocation

struct BottomBarView: View {
    @Binding var annotation: Place
    @Binding var creatingAnnotation: Bool
    @Binding var clickingMarker: Bool
    
    @Binding var nome: String
    @Binding var descricao: String
    @Binding var categoria: Categoria
    
    @State var definir: () -> Void
    
    var body: some View{
        VStack{
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 40, height: 5)
                .foregroundColor(Color(UIColor.systemGray2))

            if creatingAnnotation{
                annotationView
            }else if clickingMarker{
                markerView
            }else{
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
    
    var annotationView: some View {
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
                definir()
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
    
    var markerView: some View {
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
                    print("a")
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
    
    var defaultView: some View {
        VStack{
            
        }
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(annotation: .constant(Place(name: "teste", descricao: "teste 2", categoria: Categoria.buraco, coordinate: CLLocationCoordinate2D(latitude: 12, longitude: 12), creating: false)) , creatingAnnotation: .constant(false), clickingMarker: .constant(true), nome: .constant(""), descricao: .constant(""), categoria: .constant(Categoria.vazia)){
            print("a")
        }
    }
}
