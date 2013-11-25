part of dwt_crm_lib;
 
class Contact extends ContactGen { 
 
  Contact(Concept concept) : super(concept); 
  
  // begin: added by hand
  bool get left => !deleted;
  
  /**
   * Compares two tasks based on the title.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Contact other) {
    return email.compareTo(other.email);
  }
  
  bool preSetAttribute(String attribute, Object value) {
    bool validation = super.preSetAttribute(attribute, value);
    // Validat name
    if (attribute == 'name') {
      String name = value;
      if (validation) {
        validation = name.trim() != '';
        if (!validation) {
          var error = new ValidationError('pre');
          error.message = 'The name should not be empty.';
          errors.add(error);
        }
      }
      if (validation) {
        validation = name.length <= 64;
        if (!validation) {
          var error = new ValidationError('pre');
          error.message =
              'The name should not be longer than 64 characters.';
              errors.add(error);
        }
      }
    }
    // Validate phone
    if (attribute == 'phone') {
      String phone = value;
      if (validation) {
        validation = phone.trim() != '';
        if (!validation) {
          var error = new ValidationError('pre');
          error.message = 'The phone should not be empty.';
          errors.add(error);
        }
      }
      if (validation) {
        var exp = new RegExp(r"[0-9]{3}-[0-9]{3}-[0-9]{4}");
        validation = exp.hasMatch(value);
        if (!validation) {
          var error = new ValidationError('pre');
          error.message =
              'Phone format not valid (XXX-XXX-XXXX).';
              errors.add(error);
        }
      }
    }
    // Validate email
    if (attribute == 'email') {
      String email = value;
      if (validation) {
        validation = email.trim() != '';
        if (!validation) {
          var error = new ValidationError('pre');
          error.message = 'The phone should not be empty.';
          errors.add(error);
        }
      }
      if (validation) {
        // http://stackoverflow.com/questions/16800540/validate-email-address-in-dart
        var exp = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
        validation = exp.hasMatch(value);
        if (!validation) {
          var error = new ValidationError('pre');
          error.message =
              'Email format not valid.';
              errors.add(error);
        }
      }
    }
    return validation;
  }
  // end: added by hand
} 
 
class Contacts extends ContactsGen { 
 
  Contacts(Concept concept) : super(concept); 
  
  // begin: added by hand
  Contacts get deleted => selectWhere((contact) => contact.deleted);
  Contacts get left => selectWhere((contact) => contact.left);

  bool preAdd(Contact contact) {
    bool validation = super.preAdd(contact);
    if (validation) {
      var otherTask = firstWhereAttribute('email', contact.email);
      validation = otherTask == null;
      if (!validation) {
        var error = new ValidationError('pre');
        error.message = 'The "${contact.email}" already exists.';
        errors.add(error);
      }
    }
    return validation;
  }
  // end: added by hand
}