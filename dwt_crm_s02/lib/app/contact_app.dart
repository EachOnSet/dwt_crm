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
    ContactsEntries model = domain.getModelEntries('Contact');
    contacts = model.contacts;
    initContacts(model);

    var root = ui.RootPanel.get();
    var personApp = new ui.VerticalPanel();
    personApp.spacing = 16;
    root.add(personApp);
    var persons = new Persons(this);
    personApp.add(persons);
    header = new Header(this);
    personApp.add(header);
    footer = new Footer(this, persons);
    personApp.add(footer);

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