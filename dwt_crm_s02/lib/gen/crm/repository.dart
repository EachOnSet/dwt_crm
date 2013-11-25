part of dwt_crm_lib;

class CRMRepo extends Repo { 
  
  static final domainCode = "CRM"; 
  static final modelCode = "Contact"; 
 
  CRMRepo([String code="CRMRepo"]) : super(code) { 
    _initDomain(); 
  } 
 
  _initDomain() { 
    var domain = new Domain(domainCode); 
    domains.add(domain); 
    add(new CRMModels(domain)); 
  } 
 
} 