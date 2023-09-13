//
//  BottomBarView.swift
//  Dale
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI
import CoreLocation

struct BottomBarView: View {
    @Binding var annotations: [Place]
    @Binding var annotation: Place
    @Binding var state: Modo
    
    @Binding var nome: String
    @Binding var descricao: String
    @Binding var categoria: Categoria
    @Binding var selected: Categoria
    
    @Binding var buscar: String
    @State private var isEditing = false
    @FocusState private var isFocused: Bool
    
    @State var mainFunction: () -> Void
    @State var secondaryFunction: (_ annotation: Place) -> Void
    @State var terciaryFunction: () -> Void
    
    var body: some View{
        VStack{
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
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .frame(height: 300)
        .frame(maxWidth: .infinity)

        .background(Color("RoxoBG"))
    }
    
    var creatingView: some View {
        VStack{
            
            Text("Arraste o pin para o local desejado!")
                .foregroundColor(.white)
                .bold()
                .padding(12)
            
            Button {
                mainFunction()
            } label: {
                ZStack{
                    
                    Rectangle()
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color("MagentaMarrenta"))

                        .cornerRadius(8)
                    
                    Image("DaleHorizontal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .padding(4)
                    
                    
                }

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
                        .foregroundColor(.white)
                    Text(annotation.descricao)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button {
                    // Função de editar
                    mainFunction()
                } label: {
                    Image("Editar")
                        .resizable()
                        .frame(width: 36, height: 36)
                }
            }
            HStack{
                CategoryButton(categoria: annotation.categoria, isSelected: selected != categoria)
                
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
                            if selected == categoria {
                                selected = .vazia
                            } else {
                                selected = categoria
                            }
                            
                            self.categoria = categoria
                        } label: {
                            CategoryButton(categoria: categoria, isSelected: selected != categoria)
                        }
                    }
                }
            }
            
            Spacer()
            
            HStack {
                
                Button {
                    secondaryFunction(Place.emptyPlace)
                } label: {
                    Image("Excluir")
                        .resizable()
                        .frame(maxWidth: 36, maxHeight: 36)
                }
                
                Button {
                    mainFunction()
                } label: {
                    Text("salvar")
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(isDisabled() ? Color(.gray) : Color("MagentaMarrenta"))
                        .cornerRadius(10)
                }
                .disabled(isDisabled())
                
                Spacer()
            }
        }
    }
    
    var defaultView: some View {
        VStack{
            HStack{
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Buscar", text: $buscar)
                        .focused($isFocused)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 10)
                .background(Color("RoxoBGaux"))
                .cornerRadius(12)
                .onTapGesture {
                    mainFunction()
                    withAnimation{
                        self.isEditing = true
                        self.isFocused = true
                    }
                }
                
                if isFocused {
                    Button {
                        terciaryFunction()
                        withAnimation{
                            self.isEditing = false
                            self.isFocused = false
                        }
                        self.buscar = ""
                    } label: {
                        // Botão bonito
                        Text("Cancel")
                    }
                }else{
                    // Botão de histórico
                }
            }
            
            ScrollView{
                if buscar != ""{
                    ForEach(annotations.filter({ annotation in
                        annotation.name.lowercased().contains(buscar.lowercased())
                    })) {annotation in
                        HStack{
                            Button {
                                buscar = ""
                                isFocused = false
                                isEditing = false
                                secondaryFunction(annotation)
                            } label: {
                                Text(annotation.name)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 8)
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
    
    func isDisabled() -> Bool {
        if (nome == "" || descricao == ""){
            return true
        }else{
            return false
        }
    }
}


struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(annotations: .constant([Place.emptyPlace]), annotation: .constant(Place(name: "teste", descricao: "teste 2", categoria: Categoria.geral, coordinate: CLLocationCoordinate2D(latitude: 12, longitude: 12), state: .none)), state: .constant(.none), nome: .constant(""), descricao: .constant(""), categoria: .constant(Categoria.vazia), selected: .constant(Categoria.estacionamento), buscar: .constant("")){
            print("a")
        } secondaryFunction: {annotation in 
            print("b")
        } terciaryFunction: {
            print("c")
        }
    }
}
