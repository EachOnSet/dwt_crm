part of dwt_crm_lib; 
 
initContacts(var entries) { 
  _init(entries); 
} 
 
_init(var entries) { 
  Contact contact = new Contact(entries.contacts.concept); 
  contact.name = "John Smith"; 
  contact.email = "john@smith.com"; 
  contact.phone = "555-111-2222"; 
  contact.deleted = false;
  entries.contacts.add(contact);
 
  contact = new Contact(entries.contacts.concept); 
  contact.name = "Stephen Harper"; 
  contact.email = "wannabe@gov.com"; 
  contact.phone = "555-222-5556"; 
  contact.deleted = false;
  entries.contacts.add(contact); 
 
  contact = new Contact(entries.contacts.concept); 
  contact.name = "Barack Obama"; 
  contact.email = "godbless@america.com"; 
  contact.phone = "555-333-8888";
  contact.deleted = false;
  entries.contacts.add(contact); 
} 