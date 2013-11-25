library dwt_crm;

import "package:dwt_crm/dwt_crm_app.dart"; 
import "package:dwt_crm/dwt_crm_lib.dart"; 

void main() {
  
  var repo = new CRMRepo(); 
  var domain = repo.getDomainModels('CRM');
  new ContactApp(domain);
}
