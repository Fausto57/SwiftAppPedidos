
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

    func Guardar( id: String, name: String, email: String, password: String){
        let Pedido = Pedido(context: persistenContainer.viewContext)
        Pedido.id = id
        Pedido.name = name
        Pedido.email = email
        Pedido.password = password

        do{
            try persistenContainer.viewContext.save()
            print("Pedido Guardado")
        } catch {
            print("Fallo al Guardar en \(error)")
        }

    }

    func leerTodos() -> [Pedido] {
        let result : NSFetchRequest<Pedido> = Pedido.FetchRequest()

        do{
            return try persistenContainer.viewContext.fetch(result)
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
}
}