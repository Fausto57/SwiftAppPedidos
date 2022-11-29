import Foundation
import CoreData

class CoreDataManager {
    let persistenContainer : NSPersistentContainer

    init(){
        persistenContainer = NSPersistentContainer(name: "Pedido")
        persistenContainer.loadPersistentStores(completionHandler: { 
            (description, error) in
            if let error = error {
                fatalError("error en core data al inicializar \(error.localizedDescription)")
            }
    })

    func GuardarPedido(nombre: String, articulo: String, dirección: String, estatus: String, fecha: String, total: String){
        let pedido = Pedido(context: persistenContainer.viewContext)
        pedido.nombre = nombre
        pedido.articulo = articulo
        pedido.dirección = dirección
        pedido.estatus = estatus
        pedido.fecha = fecha
        pedido.total = total

        do{
            try persistenContainer.viewContext.save()
            print("Pedido Guardado")
        } catch {
            print("Fallo al Guardar en \(error)")
        }

    }

    func leerTodos() -> [Pedido] {
        let request: NSFetchRequest<Pedido> = Pedido.FetchRequest()

        do{
            return try persistenContainer.viewContext.fetch(request)
        } catch {
            result []
        }
    }

    func EliminarPedido(pedido : Pedido){
        persistenContainer.viewContext.delete(pedido)

        do {
            try persistenContainer.viewContext.save()
        } catch {
            persistenContainer.viewContext.rollback()
            print("Fallo al Eliminar en \(error.localizedDescription)")
        }

    }

    func ActualizaPedido(pedido: Pedido) {
        let fetchRequest = NSFetchRequest<Pedido> = Pedido.fetchRequest()
        let predicate = NSPredicate(format:"Nombre = %@", pedido.Nombre ?? "")
        fetchRequest.predicate = predicate

        do{
            let datos = try persistenContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.nombre = pedido.nombre
            p?.articulo = pedido.articulo
            p?.dirección = pedido.dirección
            p?.estatus = pedido.estatus
            p?.fecha = pedido.fecha
            p?.total = pedido.total

            try persistenContainer.viewContext.save()
            print("Producto Actualizado")
        } catch {
            print("Error al Actualizar \(error)")
        }
    }

    func leerUno(nombre: String) -> Pedido?{
        let fetchRequest = NSFetchRequest<Pedido> = Pedido.fetchRequest()
        let predicate = NSPredicate(format:"Nombre = %@", nombre)
        fetchRequest.predicate = predicate

        do{
            let datos = try persistenContainer.viewContext.fetch(fetchRequest)
            return datos.first
        } catch {
            print("Error al Actualizar \(error)")
        }
        return nil
    }
}
}