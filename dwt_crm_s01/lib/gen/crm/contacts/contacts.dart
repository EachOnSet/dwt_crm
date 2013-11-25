part of dwt_crm_lib; 
 
abstract class ContactGen extends ConceptEntity<Contact> { 
 
  ContactGen(Concept concept) : super.of(concept); 
 
  String get name => getAttribute("name"); 
  set name(String a) => setAttribute("name", a); 
  
  String get email => getAttribute("email"); 
  set email(String a) => setAttribute("email", a); 
  
  String get phone => getAttribute("phone"); 
  set phone(String a) => setAttribute("phone", a); 
  
  bool get deleted => getAttribute("deleted"); 
  set deleted(bool a) => setAttribute("deleted", a); 
  
  Contact newEntity() => new Contact(concept); 
  Contacts newEntities() => new Contacts(concept); 
  
  int emailCompareTo(Contact other) {
    return email.compareTo(other.email);
  }
} 
 
abstract class ContactsGen extends Entities<Contact> { 
 
  ContactsGen(Concept concept) : super.of(concept); 
 
  Contacts newEntities() => new Contacts(concept); 
  Contact newEntity() => new Contact(concept); 
  
}