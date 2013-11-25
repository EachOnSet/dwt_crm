part of dwt_crm_app;

/**
 * Header composite component
 */
class Header extends ui.VerticalPanel implements PastReactionApi {
  Contacts _contacts;

  ui.CheckBox _completeAll;
  ui.HtmlPanel _header;
  ui.Button _undo;
  ui.Button _redo;
  ui.Button _clearNewPerson;

  /**
   * Create new instance of [Header].
   */
  Header(ContactApp todoApp) {
    DomainSession _session = todoApp.session;
    _session.past.startPastReaction(this);
    _contacts = todoApp.contacts;
    spacing = 16;
    
    var appTitle = new ui.Label('DWT CRM');
    appTitle.addStyleName('app-title');
    add(appTitle);
    
    _completeAll = new ui.CheckBox('Check all');
    updateDisplay();
    _completeAll.addValueChangeHandler(new event.ValueChangeHandlerAdapter(
      (event.ValueChangeEvent e) {
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
      })
    );
    
    _undo = new ui.Button(
      'Undo', new event.ClickHandlerAdapter((event.ClickEvent e) {
        _session.past.undo();
      })
    );
    _undo.enabled = false;
    _undo.addStyleName('todo-button disabled');

    _redo = new ui.Button(
      'Redo', new event.ClickHandlerAdapter((event.ClickEvent e) {
        _session.past.redo();
      })
    );
    _redo.enabled = false;
    _redo.addStyleName('todo-button disabled');
    
    ui.Grid newPersonPanel = new ui.Grid(3, 4);
    newPersonPanel.setCellSpacing(12);
    newPersonPanel.getRowFormatter().setVerticalAlign(
      0, i18n.HasVerticalAlignment.ALIGN_MIDDLE);
    add(newPersonPanel);
    
    var labName = new ui.Label('Name');
    var labPhone = new ui.Label('Phone');
    var labEmail = new ui.Label('Email');
    newPersonPanel.setWidget(0, 0, labName);
    newPersonPanel.setWidget(0, 1, labPhone);
    newPersonPanel.setWidget(0, 2, labEmail);
    var msgError = new ui.Label('');
    newPersonPanel.setWidget(2, 0, msgError);
    newPersonPanel.setWidget(2, 1, _completeAll);
    newPersonPanel.setWidget(2, 2, _undo);
    newPersonPanel.setWidget(2, 3, _redo);
    
    // Key handlers
    var newName = new ui.TextBox();
    newName.addStyleName('todo-input');
    var newPhone = new ui.TextBox();
    newPhone.addStyleName('todo-input');
    var newEmail = new ui.TextBox();
    newEmail.addStyleName('todo-input');
    
    newName.addKeyPressHandler(new
      event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
        if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
          var name = newName.text.trim();
          var phone = newPhone.text.trim();
          var email = newEmail.text.trim();
          var contact = new Contact(_contacts.concept);
          contact.name = name;
          contact.phone = phone;
          contact.email = email;
          bool done = new AddAction(_session, _contacts, contact).doit();
          if (done) {
            newName.text = '';
            newPhone.text = '';
            newEmail.text = '';
            msgError.text = '';
            _clearNewPerson.enabled = false;
            _clearNewPerson.addStyleName('disabled');
          } else {
            var e = '';
            for (ValidationError ve in _contacts.errors) {
              e = '${ve.message} $e';
            }
            for (ValidationError ve in contact.errors) {
              e = '${ve.message} $e';
            }
            msgError.text = '$e';
            _contacts.errors.clear();
            contact.errors.clear();
            _clearNewPerson.enabled = true;
            _clearNewPerson.removeStyleName('disabled');
          }
        } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
          newName.text = '';
          newPhone.text = '';
          newEmail.text = '';
          msgError.text = '';
        } else {
          _clearNewPerson.enabled = true;
          _clearNewPerson.removeStyleName('disabled');
        }
      })
    );
    
    newPhone.addKeyPressHandler(new
      event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
        if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
          var name = newName.text.trim();
          var phone = newPhone.text.trim();
          var email = newEmail.text.trim();
          var contact = new Contact(_contacts.concept);
          contact.name = name;
          contact.phone = phone;
          contact.email = email;
          bool done = new AddAction(_session, _contacts, contact).doit();
          if (done) {
            newName.text = '';
            newPhone.text = '';
            newEmail.text = '';
            msgError.text = '';
            _clearNewPerson.enabled = false;
            _clearNewPerson.addStyleName('disabled');
          } else {
            var e = '';
            for (ValidationError ve in _contacts.errors) {
              e = '${ve.message} $e';
            }
            for (ValidationError ve in contact.errors) {
              e = '${ve.message} $e';
            }
            msgError.text = '$e';
            _contacts.errors.clear();
            contact.errors.clear();
            _clearNewPerson.enabled = true;
            _clearNewPerson.removeStyleName('disabled');
          }
        } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
          newName.text = '';
          newPhone.text = '';
          newEmail.text = '';
          msgError.text = '';
        } else {
          _clearNewPerson.enabled = true;
          _clearNewPerson.removeStyleName('disabled');
        }
      })
    );
    
    newEmail.addKeyPressHandler(new
      event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
        if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
          var name = newName.text.trim();
          var phone = newPhone.text.trim();
          var email = newEmail.text.trim();
          var contact = new Contact(_contacts.concept);
          contact.name = name;
          contact.phone = phone;
          contact.email = email;
          bool done = new AddAction(_session, _contacts, contact).doit();
          if (done) {
            newName.text = '';
            newPhone.text = '';
            newEmail.text = '';
            msgError.text = '';
            _clearNewPerson.enabled = false;
            _clearNewPerson.addStyleName('disabled');
          } else {
            var e = '';
            for (ValidationError ve in _contacts.errors) {
              e = '${ve.message} $e';
            }
            for (ValidationError ve in contact.errors) {
              e = '${ve.message} $e';
            }
            msgError.text = '$e';
            _contacts.errors.clear();
            contact.errors.clear();
            _clearNewPerson.enabled = true;
            _clearNewPerson.removeStyleName('disabled');
          }
        } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
          newName.text = '';
          newPhone.text = '';
          newEmail.text = '';
          msgError.text = '';
        } else {
          _clearNewPerson.enabled = true;
          _clearNewPerson.removeStyleName('disabled');
        }
      })
    );
    
    newPersonPanel.setWidget(1, 0, newName);
    newPersonPanel.setWidget(1, 1, newPhone);
    newPersonPanel.setWidget(1, 2, newEmail);
    
    _clearNewPerson = new ui.Button(
      'Clear', new event.ClickHandlerAdapter((event.ClickEvent e) {
        newName.text = '';
        newPhone.text = '';
        newEmail.text = '';
        msgError.text = '';
        newName.focus = true;
        _clearNewPerson.addStyleName('disabled');
        _clearNewPerson.enabled = false;
      })
    );
    _clearNewPerson.enabled = false;
    _clearNewPerson.addStyleName('todo-button disabled');
    newPersonPanel.setWidget(1, 3, _clearNewPerson);
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

  reactCannotUndo() {
    _undo.enabled = false;
    _undo.addStyleName('disabled');
  }

  reactCanUndo() {
    _undo.enabled = true;
    _undo.removeStyleName('disabled');
  }

  reactCanRedo() {
    _redo.enabled = true;
    _redo.removeStyleName('disabled');
  }

  reactCannotRedo() {
    _redo.enabled = false;
    _redo.addStyleName('disabled');
  }
}