import SwiftUI

struct ContentView: View {
    let coreDM : CoreDat aManager
    @State var id = ""
    @state var nombre = ""              
    @State var precio =
    @State var prodArray = [Producto ] ()
        var body: some View {
            VStack{
                TextField ( "Nombre producto", text: $nombre)
                .textFieldStyle (RoundedBorderTextFieldStyle ())
                TextField ("Código producto", text: $codigo)
                textFieldStyle (RoundedBorderText FieldStyle ())
                TextField ("Precio producto", text: $precio)
                .textFieldStyle (RoundedBorderTextFieldStyle () )
                Button ("Save"){
                    coreDM.guardarProducto (id: , nombre: nombre, precio: precio)
                    mostrarProductos ()
                    nombre ""
                    id = ""
                    precio = ""
                }
                List {
                ForEach (prodArray, id: \.self){
                    prod in
                    VStack{
                      Text(prod.id ?? "")
                      Text(prod.id ?? "")
                      Text(prod.id ?? "")
                    }
                .onDelete(perform: {                
                    indexS in
                    indexS.ForEach({
                        let pedido = prodArray[index]
                        coreDM.BorrarPedido(pedido: pedido)
                        mostrarProductos()
                    })
                })
            }
            Spacer()
                }.pading()
                   .onAppear(perform: {
                   mostrarProductos()
            }

            }

            func mostrarProductos() {
                prodArray = CoreDM.leerTodos()
            }
        }
}

struct ContentView_Previews : PreviewProvider{
    static var previews: some View {
        ContentView(CoreDM: CoreDataManager())
    }
}



