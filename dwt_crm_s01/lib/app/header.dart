part of dwt_crm_app;

/**
 * Header composite component
 */
class Header extends ui.Composite {
  Contacts _contacts;
  DomainSession _session;

  ui.SimpleCheckBox _completeAll;
  ui.HtmlPanel _header;
  ui.TextBox _newName;
  ui.TextBox _newPhone;
  ui.TextBox _newEmail;

  /**
   * Create new instance of [Header].
   */
  Header(ContactApp todoApp) {
    _session = todoApp.session;
    _contacts = todoApp.contacts;

    // Get #header from page
    _header = new ui.HtmlPanel.wrap(querySelector("#header"));
    initWidget(_header);

    // Get #toggle-all checkbox from page
    _completeAll = new ui.SimpleCheckBox.wrap(querySelector("#toggle-all"));
    updateDisplay();
    _completeAll.addClickHandler(new event.ClickHandlerAdapter(_completeAllHandler));
    _completeAll.addKeyPressHandler(new event.KeyPressHandlerAdapter(_completeAllHandler));

    // Get #new imput from page
    _newName = new ui.TextBox.wrap(querySelector("#new-name"));
    _newPhone = new ui.TextBox.wrap(querySelector("#new-phone"));
    _newEmail = new ui.TextBox.wrap(querySelector("#new-email"));
    
    // Key handlers
    _newName.addKeyPressHandler(new
      event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
        if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
          var contact = new Contact(_contacts.concept);
          contact.name = _newName.text.trim();
          contact.phone = _newPhone.text.trim();
          contact.email = _newEmail.text.trim();
          bool done = new AddAction(_session, _contacts, contact).doit();
          if (done) {
            _newName.text = '';
            _newPhone.text = '';
            _newEmail.text = '';
          } else {
            var e = '';
            for (ValidationError ve in _contacts.errors) {
              e = '${ve.message} $e';
            }
            for (ValidationError ve in contact.errors) {
              e = '${ve.message} $e';
            }
            _newName.text = '$e';
            _contacts.errors.clear();
            contact.errors.clear();
          }
        } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
          _newName.text = '';
          _newPhone.text = '';
          _newEmail.text = '';
        }
      })
    );
  }

  /**
   * Update information in all corresponding elements on page.
   */
  updateDisplay() {
    var allLength = _contacts.length;
    if (allLength > 0) {
      _completeAll.enabled = true;
      var completedLength = _contacts.deleted.length;
      if (allLength > 0 && allLength == completedLength) {
        _completeAll.setValue(true);
      } else {
        _completeAll.setValue(false);
      }
    } else {
      _completeAll.setValue(false);
      _completeAll.enabled = false;
    }
  }

  /**
   * Toggel button click and key press handler.
   */
  void _completeAllHandler(event.DwtEvent evt) {
    if (_contacts.length > 0) {
      var transaction = new Transaction('complete-all', _session);
      if (_contacts.left.length == 0) {
        for (Contact contact in _contacts) {
          transaction.add(
              new SetAttributeAction(_session, contact, 'deleted', false));
        }
      } else {
        for (Contact contact in _contacts.left) {
          transaction.add(
              new SetAttributeAction(_session, contact, 'deleted', true));
        }
      }
      transaction.doit();
    }
  }
}