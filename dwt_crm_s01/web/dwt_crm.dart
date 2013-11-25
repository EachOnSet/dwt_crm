library dwt_crm;

import 'dart:html';
import "package:dartling/dartling.dart"; 
import "package:dartling_default_app/dartling_default_app.dart";

import "package:dwt_crm/dwt_crm_app.dart"; 
import "package:dwt_crm/dwt_crm_lib.dart"; 

void main() {
  
  var repo = new CRMRepo(); 
  var domain = repo.getDomainModels('CRM');
  initData(repo);
  var app = new ContactApp(domain);
  //app.save();
  //app.updateDisplay();
  //initView(repo); 
}

void initData(CRMRepo inRepo) { 
  var models = inRepo.getDomainModels(CRMRepo.domainCode); 
  var ContactsEntries = models.getModelEntries(CRMRepo.modelCode); 
  
  initContacts(ContactsEntries);
  ContactsEntries.display(); 
  ContactsEntries.displayJson(); 
} 
 
void initView(CRMRepo mngRepo) { 
   var mainView = new View(document, "right"); 
   mainView.repo = mngRepo; 
   new RepoMainSection(mainView); 
} 


