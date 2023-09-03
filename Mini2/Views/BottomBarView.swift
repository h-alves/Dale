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
                        CategoryButton(categoria: categoria)
                    }
                }
            }
            
            Spacer()
            
            Button {
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
        VStack{
            Text(annotation.name)
        }
    }
    
    var defaultView: some View {
        VStack{
            
        }
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(annotation: .constant(Place(name: "", coordinate: CLLocationCoordinate2D(latitude: 12.3, longitude: 13.4), creating: false)) , creatingAnnotation: .constant(false), clickingMarker: .constant(false), nome: .constant(""), descricao: .constant("")){
            print("a")
        }
    }
}
