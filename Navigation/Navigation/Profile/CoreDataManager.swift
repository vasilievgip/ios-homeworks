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

    private init() { }

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "ModelCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    lazy var backgroundContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()

    func addPost(post: User.CurrentPost) {
        backgroundContext.perform {
            if self.getPost(byDescription: post.descr) == nil {
                let newPost = Post(context: self.backgroundContext)
                newPost.author = post.author
                newPost.descr = post.descr
                newPost.image = post.image
                newPost.likes = post.likes
                newPost.views = post.views
                try? self.backgroundContext.save()
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

    func getOldPost(byDescription description: String?) -> Post? {
        guard let description else {return nil}
        let fetchRequest = Post.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "descr == %@", description)
        return (try? persistentContainer.viewContext.fetch(fetchRequest))?.first
    }

    func filterPostAuthor(byAuthor author: String) {
        reloadPosts()
        let fetchRequest = Post.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "author CONTAINS[c] %@", author)
        do {
            let postsRequest = try persistentContainer.viewContext.fetch(fetchRequest)
            deleteAllPosts()
            for post in postsRequest {
                resumePost(post: post)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func noFilterPostAuthor() {
        for post in posts {
            resumePost(post: post)
        }
        try? persistentContainer.viewContext.save()
    }

    func resumePost(post: Post) {
        if self.getOldPost(byDescription: post.descr) == nil {
            let oldPost = Post(context: persistentContainer.viewContext)
            oldPost.author = post.author
            oldPost.descr = post.descr
            oldPost.image = post.image
            oldPost.likes = post.likes
            oldPost.views = post.views
        }
    }

    func deleteAllPosts() {
        let fetchRequest = Post.fetchRequest()
        for post in (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? [] {
            persistentContainer.viewContext.delete(post)
        }

    }

    func deletePost(post: Post) {
        persistentContainer.viewContext.delete(post)
        try? persistentContainer.viewContext.save()
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
