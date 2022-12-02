import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    init(){
        persistentContainer = NSPersistentContainer(name: "Pedidos")
        persistentContainer.loadPersistentStores(completionHandler: {
            (descripcion, error) in
            if let error = error {
                fatalError("Error al inicializar CoreData en \(error.localizedDescription)")
            }
        })
    }
    
    func guardarPedido(id:String, cliente:String, articulo:String, total:String, estado:String){
        let pedido = Pedido(context : persistentContainer.viewContext)
        pedido.id = id
        pedido.cliente=cliente
        pedido.articulo=articulo
        pedido.total=total
        pedido.estado = estado
        
        do{
            try persistentContainer.viewContext.save()
            print("Pedido guardado")
        }
        catch{
            print("Fallo al guardar en \(error)")
        }
    }
    
    func leerTodosLosPedidos()-> [Pedido]{
        let fetchRequest:NSFetchRequest<Pedido>=Pedido.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return[]
        }
    }
    
    func leerPedido(id:String)->Pedido?{
        let fetchRequest:NSFetchRequest<Pedido>=Pedido.fetchRequest()
        let predicate = NSPredicate(format:"id=%@",id)
        fetchRequest.predicate=predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }
        catch{
            print("Fallo al guardar en \(error)")
        }
        return nil
        
    }
    
    func actualizaraPedido(pedido:Pedido){
        //var ped=persistentContainer.viewContext.updatedObjects([pedido])
        let fetchRequest:NSFetchRequest<Pedido>=Pedido.fetchRequest()
        let predicate = NSPredicate(format:"id=%@",pedido.id ?? "")
        fetchRequest.predicate=predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let p=datos.first
            p?.articulo=pedido.articulo
            p?.cliente=pedido.cliente
            p?.estado=pedido.estado
            p?.id=pedido.id
            p?.total=pedido.total
            try persistentContainer.viewContext.save()
            print("pedido Actualizado")
        }
        catch{
            print("Fallo al guardar en \(error)")
        }
        
    }
    
    func borrarPedido(pedido: Pedido){
        persistentContainer.viewContext.delete(pedido)
        
        do{
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Fallo el borrado en \(error.localizedDescription)")
        }
    }
}