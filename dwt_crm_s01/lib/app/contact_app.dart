part of dwt_crm_app;

/**
 * Todo Application entry point.
 */
class ContactApp {
  CRMModels domain;
  DomainSession session;
  Contacts contacts;

  Header header;
  Footer footer;

  /**
   * Create new instance of [ContactApp].
   */
  ContactApp(this.domain) {
    session = domain.newSession();
    ContactsEntries model = domain.getModelEntries('Contacts');
    contacts = model.contacts;

    header = new Header(this);
    Persons persons = new Persons(this);
    footer = new Footer(this, persons);

    updateDisplay();
  }

  /**
   * Save list of task to local storage.
   */
  save() {
    window.localStorage['crm-dartling-dwt'] = JSON.encode(contacts.toJson());
  }

  /**
   * Update header and footer components on page.
   */
  updateDisplay() {
    header.updateDisplay();
    footer.updateDisplay();
  }
}