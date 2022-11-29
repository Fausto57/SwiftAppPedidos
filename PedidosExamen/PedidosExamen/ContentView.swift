//
//  ContentView.swift
//  PedidosExamen
//
//  Created by CCDM03 on 14/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDM : CoreDataManager
    @State var Nombre: String = ""
    @State var Articulo: String = ""
    @State var Dirección: String = ""
    @State var Estatus: String = ""
    @State var Fecha: String = ""
    @State var Total: String = ""
    @State var seleccionado:Pedido?
    @State var traeTodos=[Pedido]()

    var body: some View {
        VStack{
            TextField("Ingrese Su Nombre", text: $Nombre)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Ingrese Nombre Articulo", text: $Articulo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Ingrese Dirección", text: $Dirección)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Ingrese Estatus de Articulo", text: $Estatus)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Ingrese Fecha", text: $Fecha)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Ingrese Total", text: $Total)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Guardar"){
                if(seleccionado != nil){
                    seleccionado?.nombre = Nombre
                    seleccionado?.articulo = Articulo
                    seleccionado?.dirección = Dirección
                    seleccionado?.estatus = Estatus
                    seleccionado?.fecha = Fecha
                    seleccionado?.total = Total
                    CoreDM.ActualizaPedido(Pedido: seleccionado!)
                }else{
                    CoreDM.GuardarPedido(nombre: String, articulo: String, dirección: String, estatus: String, fecha: String, total: String)
                }
                MPedidos()
                Nombre = ""
                Articulo = ""
                Dirección = ""
                Estatus = ""
                Fecha = ""
                Total = ""
                seleccionado=nil
            }
            List{
                ForEach(traeTodos, nombre: \.self){
                    ped in
                    VStack{
                        Text(ped.nombre ?? "")
                        Text(ped.Articulo ?? "")
                        Text(ped.Dirección ?? "")
                        Text(ped.Estatus ?? "")
                        Text(ped.Fecha ?? "")
                        Text(ped.Total ?? "")
                    }.onTapGesture{
                        seleccionado=ped
                        Nombre=ped.nombre ?? ""
                        Articulo=ped.articulo ?? ""
                        Dirección=ped.dirección ?? ""
                        Estatus=ped.estatus ?? ""
                        Fecha=ped.fecha ?? ""
                        Total=ped.total ?? ""
                    }
                }
                .onDelete(perform: {
                    indexSet in
                    indexSet.forEach({index in let pedido=traeTodos[index]
                        CoreDM.EliminarPedido(pedido: pedido)
                        MPedidos()
                    })
                })
            }
            Spacer()
        }.padding()
            .onAppear(perform:{
                MPedidos()
            })
    }

    func MPedidos(){
        traeTodos=CoreDM.leerTodos()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(CoreDM: CoreDataManager())
    }
}
