//
//  StorageManager.swift
//  UserDefaults
//
//  Created by Sergey on 20.08.2021.
//
//


// рефактори вью под DATA 
import Foundation

// UserDefaults сохранение удаление восстановление
class StorageManager {
    static let shared = StorageManager()
    
  //  private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let contactKey = "contacts"
    
    
    // plist открываем finder переход к папке и копируем путь с консоли
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    // указать диретрорию по которой будет новый файл
    private var archiveURL: URL
    
    private init() {
       // print(documentDirectory) берем адрес
        //  в этой директории  где находится и как найти
        archiveURL = documentDirectory.appendingPathComponent("contacts").appendingPathExtension("plist")
        
    }
    
    
    // для сохранения экземпляров модели
    
    func save(contact: Contact) {
        var contacts = fetchContacts()
        // добавляем в массив данные
        contacts.append(contact)
        // сохраняем массив  с типом data
        guard let data = try? JSONEncoder().encode(contacts) else { return }// из массива делаем data
        // сохраняем данные в юсердефолдс
        userDefaults.set(data, forKey: contactKey)
        
        
        
    }
    
    // plist
    func saveTofile(with contact: Contact) {
        var contacts = fetchFromFile()
        contacts.append(contact)
        
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
        try? data.write(to: archiveURL, options: .noFileProtection)
        
        
    }
    
    
    
   
    
    func fetchContacts() -> [Contact] {
       //восстановить массив контактов из userDefaults
        guard let data = userDefaults.object(forKey: contactKey) as? Data else { return [] }
        // из data делаем экземпляр модели
        guard let contacts = try? JSONDecoder().decode([Contact].self, from: data) else { return [] }   // подписиваем под протокол в модели Codable
        return contacts // теперь идем работать в метод func save(contact: Contact)
    }
    
    
    // plist
     //данные восстанавливаются из файла а не из Юзердефолд
    func fetchFromFile() -> [Contact] {
        
        guard let data = try? Data(contentsOf: archiveURL) else { return [] }
        guard let contacts = try? PropertyListDecoder().decode([Contact].self, from: data) else { return [] }
        return contacts
    }
    
    
    
    
    
    
    // удаление данных с типом data
    func delete(at index: Int) {
        // восстанавливаем массив
        var contacts = fetchContacts()
        
        //есть массив удаляем из него элемент
        contacts.remove(at: index)
        
        //запаковываем и сохраняем в data
        guard let data = try? JSONEncoder().encode(contacts) else { return }// из массива делаем data
        // сохраняем данные в юсердефолдс
        userDefaults.set(data, forKey: contactKey)
        
    }
    
    // plist delete
    
    func deleteFromFile(at index: Int) {
        
        var contacts = fetchContacts()
        //есть массив удаляем из него элемент
        contacts.remove(at: index)
        
        
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
        try? data.write(to: archiveURL, options: .noFileProtection)
        
        
    }
    
    
    
    
    
    
    
    
    
    
}
    

















    /*
func save(contact: String) {
        // в любом случаи восстанавливаем массив первым делом
        // кладем туда новую запись
        // после этого сохраняем
        var contacts = fetchContacts() //у нас есть массив
        
        // в этот массив помещаем новый элемент
        contacts.append(contact)// берем из параметра  и снова сохраняем
        userDefaults.set(contacts, forKey: contactKey)
        
        
    }
    // метод по восстановлению данных
    func fetchContacts() -> [String] {
        // если что то есть в UserDefault извлекаем и отоброжаем во вью
        if let contacts = userDefaults.value(forKey: contactKey) as? [String] {
            //принудительное извлечение опционала знаем что тип данных string as!
          return contacts
        }
        return []
    }
    
    
    
    // работа  с удалением
    
    func delete(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        userDefaults.set(contacts, forKey: contactKey)// сохранили данные 
        
    }
    
    
  */
    
    
















