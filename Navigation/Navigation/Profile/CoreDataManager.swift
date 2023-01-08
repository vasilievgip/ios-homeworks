//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Андрей Васильев on 27.12.2022.
//

import CoreData
import UIKit


class CoreDataManager {

    static let defaultManager = CoreDataManager()

    private init() { reloadPosts() }

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

    lazy var backgroundContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()

    func addPost(author: String, description: String, image: Data, likes: Int64, views: Int64) {
        backgroundContext.perform {
            if self.getPost(byDescription: description) == nil {
                let newPost = Post(context: self.backgroundContext)
                newPost.author = author
                newPost.descr = description
                newPost.image = image
                newPost.likes = likes
                newPost.views = views
                try? self.backgroundContext.save()
                self.reloadPosts()
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Добавлено в избранное", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { action in
                    }))
                    ProfileViewController.defaultViewController.present(alert, animated: true)
                }
            } else {
                print("Уже есть в избранном")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Уже в избранном", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { action in
                    }))
                    ProfileViewController.defaultViewController.present(alert, animated: true)
                }
            }
        }
    }

    func getPost(byDescription description: String?) -> Post? {
        guard let description else {return nil}
        let fetchRequest = Post.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "descr == %@", description)
        return (try? backgroundContext.fetch(fetchRequest))?.first
    }

    func filterPostAuthor(byAuthor author: String) {
        let fetchRequest = Post.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "author == %@", author)
        do {
            let postsRequest = try persistentContainer.viewContext.fetch(fetchRequest)
            posts = postsRequest
        } catch {
            print(error.localizedDescription)
            posts = []
        }
    }

    func deletePost(post: Post) {
        self.managedContext.delete(post)
        try? managedContext.save()
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
