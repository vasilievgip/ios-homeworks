//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Андрей Васильев on 27.12.2022.
//

import CoreData


class CoreDataManager {

    static let defaultManager = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "ModelCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = self.persistentContainer.viewContext

    func saveContext () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func addPost(author: String, description: String, image: Data, likes: Int64, views: Int64) {
        let newPost = Post(context: persistentContainer.viewContext)
        newPost.author = author
        newPost.descr = description
        newPost.image = image
        newPost.likes = likes
        newPost.views = views
        try? managedContext.save()
        reloadPosts()
    }

    func deletePost(post: Post) {
        self.managedContext.delete(post)
        try? managedContext.save()
        reloadPosts()
    }

    init() {
        reloadPosts()
    }

    var posts: [Post] = []

    func reloadPosts() {
        let fetchRequest = Post.fetchRequest()
        do {
            let postsRequest = try persistentContainer.viewContext.fetch(fetchRequest)
            posts = postsRequest
        } catch {
            print(error.localizedDescription)
            posts = []
        }
    }

}
