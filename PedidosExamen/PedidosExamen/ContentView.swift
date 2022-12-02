//
//  ContentView.swift
//  PedidosExamen
//
//  Created by CCDM03 on 14/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let CoreDM: CoreDataManager
    @State var id=""
    @State var cliente=""
    @State var articulo=""
    @State var total=""
    @State var estado=""
    @State var seleccionado: Pedido?
    @State var pedArray=[Pedido]()
    
    var body: some View {
        VStack{
            TextField("Id", text: $id).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Cliente", text: $cliente).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Articulo", text: $articulo).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Total", text: $total).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Estado", text: $estado).textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save"){
                if(seleccionado != nil){
                    seleccionado?.id=id
                    seleccionado?.articulo=articulo
                    seleccionado?.cliente=cliente
                    seleccionado?.estado=estado
                    seleccionado?.total=total
                    CoreDM.actualizaraPedido(pedido: seleccionado!)
                }else{
                    CoreDM.guardarPedido(id: id, cliente: cliente, articulo: articulo, total: total, estado: estado)
                }
                mostrarPedidos()
                id=""
                cliente=""
                articulo=""
                total=""
                estado=""
                seleccionado=nil
            }
            List{
                ForEach(pedArray,id: \.self){
                    ped in
                    VStack{
                        Text(ped.id ?? "")
                        Text(ped.cliente ?? "")
                        Text(ped.articulo ?? "")
                        Text(ped.total ?? "")
                        Text(ped.estado ?? "")
                    }.onTapGesture{
                        seleccionado=ped
                        id=ped.id ?? ""
                        articulo=ped.articulo ?? ""
                        cliente=ped.cliente ?? ""
                        estado=ped.estado ?? ""
                        total=ped.total ?? ""
                    }
                }
                .onDelete(perform: {
                    indexSet in
                    indexSet.forEach({index in let pedido=pedArray[index]
                        CoreDM.borrarPedido(pedido: pedido)
                        mostrarPedidos()
                    })
                })
            }
            Spacer()
        }.padding()
            .onAppear(perform:{
                        mostrarPedidos()
            })
    }
    func mostrarPedidos(){
        pedArray=CoreDM.leerTodosLosPedidos()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(CoreDM:CoreDataManager())
    }
}