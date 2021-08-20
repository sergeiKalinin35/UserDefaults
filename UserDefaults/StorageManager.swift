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
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let contactKey = "contacts"

    
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
    
    
   
    
    func fetchContacts() -> [Contact] {
       //восстановить массив контактов из userDefaults
        guard let data = userDefaults.object(forKey: contactKey) as? Data else { return [] }
        // из data делаем экземпляр модели
        guard let contacts = try? JSONDecoder().decode([Contact].self, from: data) else { return [] }   // подписиваем под протокол в модели Codable
        return contacts // теперь идем работать в метод func save(contact: Contact)
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
    
    
















