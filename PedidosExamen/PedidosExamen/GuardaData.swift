import SwiftUI

struct GuardaData: View {
    let coreDM : CoreDataManager
    @State var Nombre: String = ""
    @State var Articulo: String = ""
    @State var Dirección: String = ""
    @State var Estatus: String = ""
    @State var Fecha: String = ""
    @State var Total: String = ""
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
                
            Button ("Save"){
                    coreDM.guardarProducto (id: id, nombre: nombre, precio: precio)
                    mostrarProductos ()
                    Nombre = ""
                    Articulo = ""
                    Dirección = ""
                    Estatus = ""
                    Fecha = ""
                    Total = ""
                }
        }
    }
}

struct GuardarData_Previews: PreviewProvider {
    static var previews: some View {
        GuardaData()
    }
}