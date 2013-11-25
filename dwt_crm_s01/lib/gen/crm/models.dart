part of dwt_crm_lib; 
 
class CRMModels extends DomainModels { 
 
  CRMModels(Domain domain) : super(domain) { 
    add(fromJSONToContact()); 
  } 
 
  ContactsEntries fromJSONToContact() { 
    return new ContactsEntries(fromJsonToModel( 
      contactsModelJson, 
      domain, 
      CRMRepo.modelCode)); 
  } 
 
}