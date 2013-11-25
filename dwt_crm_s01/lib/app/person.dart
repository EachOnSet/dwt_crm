part of dwt_crm_app;

/**
 * Todo composite component.
 */
class Person extends ui.Composite {
  Contact contact;

  ListItem _li;
  ui.FlowPanel _view;
  CheckBox _completed;
  Label _name;
  Label _email;
  Label _phone;
  ui.Button _remove;
  ui.TextBox _editName;
  ui.TextBox _editPhone;
  ui.TextBox _editEmail;
  ui.Grid _grid;

  /**
   * Create an instance of [Person].
   */
  Person(ContactApp todoApp, this.contact) {
    DomainSession session = todoApp.session;
    Contacts contacts = todoApp.contacts;

    // Create new LI element
    _li = new ListItem();
    initWidget(_li);

    // FlowPanel based on DIV element
    _view = new ui.FlowPanel();
    _view.addStyleName("view");
    _li.addContent(_view);

    // Completed CheckBox
    _completed = new CheckBox(new CheckboxInputElement());
    _completed.addStyleName("toggle");
    _completed.setValue(contact.deleted);
    _completed.addValueChangeHandler(new event.ValueChangeHandlerAdapter((event.ValueChangeEvent e) {
        new SetAttributeAction(session, contact, 'deleted', !contact.deleted).doit();
      })
    );
    //
    _view.add(_completed);
    // Mark it attached and remember it for cleanup.
    _attachToRootPanel(_completed);

    // Person label
    _name = new Label();
    _name.text = contact.name;
    _name.addDoubleClickHandler(new event.DoubleClickHandlerAdapter((event.DoubleClickEvent e) {
      _li.addStyleName("editing");
      _editName.focus = true;
    }));
    _view.add(_name);
    _phone = new Label();
    _phone.text = contact.phone;
    _phone.addDoubleClickHandler(new event.DoubleClickHandlerAdapter((event.DoubleClickEvent e) {
      _li.addStyleName("editing");
      _editPhone.focus = true;
    }));
    _view.add(_phone);
    _email = new Label();
    _email.text = contact.email;
    _email.addDoubleClickHandler(new event.DoubleClickHandlerAdapter((event.DoubleClickEvent e) {
      _li.addStyleName("editing");
      _editEmail.focus = true;
    }));
    _view.add(_email);
    // Mark it attached and remember it for cleanup.
    _attachToRootPanel(_name);
    _attachToRootPanel(_phone);
    _attachToRootPanel(_email);

    // Remove button
    _remove = new ui.Button();
    _remove.addStyleName("destroy");
    _remove.addClickHandler(new event.ClickHandlerAdapter((event.ClickEvent e) {
        new RemoveAction(session, contacts, contact).doit();
     }));
    _view.add(_remove);
    // Mark it attached and remember it for cleanup.
    _attachToRootPanel(_remove);

    // Edit TextBox
    _editName = new ui.TextBox();
    _editName.addStyleName("edit");
    _editName.setValue(contact.name);
    _editName.addKeyDownHandler(new
      event.KeyDownHandlerAdapter((event.KeyDownEvent e) {
        if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
          _updatePerson(session, contacts);
        } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
          _displayPerson();
        }
      })
    );
    _editName.addBlurHandler(new event.BlurHandlerAdapter((event.BlurEvent evt) {
      _updatePerson(session, contacts);
    }));
    _li.addContent(_editName);
    // Phone
    _editPhone = new ui.TextBox();
    _editPhone.addStyleName("edit");
    _editPhone.setValue(contact.phone);
    _editPhone.addKeyDownHandler(new
      event.KeyDownHandlerAdapter((event.KeyDownEvent e) {
        if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
          _updatePerson(session, contacts);
        } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
          _displayPerson();
        }
      })
    );
    _editPhone.addBlurHandler(new event.BlurHandlerAdapter((event.BlurEvent evt) {
      _updatePerson(session, contacts);
    }));
    _li.addContent(_editPhone);
    // Email
    _editEmail = new ui.TextBox();
    _editEmail.addStyleName("edit");
    _editEmail.setValue(contact.email);
    _editEmail.addKeyDownHandler(new
      event.KeyDownHandlerAdapter((event.KeyDownEvent e) {
        if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
          _updatePerson(session, contacts);
        } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
          _displayPerson();
        }
      })
    );
    _editEmail.addBlurHandler(new event.BlurHandlerAdapter((event.BlurEvent evt) {
      _updatePerson(session, contacts);
    }));
    _li.addContent(_editEmail);
    // Mark it attached and remember it for cleanup.
    _attachToRootPanel(_editName);
    _attachToRootPanel(_editPhone);
    _attachToRootPanel(_editEmail);
  }

  /**
   * Create or Update new Contact content.
   */
  void _updatePerson(DomainSession session, Contacts contacts) {
    var newName = _editName.text;
    var newPhone = _editPhone.text;
    var newEmail = _editEmail.text;
    var otherTask = contacts.firstWhereAttribute('email', newEmail);
    if (otherTask == null) {
      bool done = new SetAttributeAction(
          session, contact, 'name', newName).doit();
      done = new SetAttributeAction(
          session, contact, 'phone', newPhone).doit();
      done = new SetAttributeAction(
          session, contact, 'email', newEmail).doit();
      if (!done) {
        _editName.setValue(contact.name);
        _editPhone.setValue(contact.phone);
        _editEmail.setValue(contact.email);
        contacts.errors.clear();
      }
    } else {
      _displayPerson();
    }
  }

  /**
   * Change LI style depends on task [completed] status.
   */
  delete(bool completed) {
    _completed.setValue(completed);
    _li.addStyleName('completed');
  }

  /**
   * Remove editing style from LI element.
   */
  _displayPerson() {
    _li.removeStyleName("editing");
  }

  /**
   * Rename Contact with new [name].
   */
  rename(String inName) {
    _name.text = inName;
    _editName.setValue(inName);
    _displayPerson();
  }
  
  /**
   * Rephone Contact with new [phone].
   */
  rephone(String inPhone) {
    _phone.text = inPhone;
    _editPhone.setValue(inPhone);
    _displayPerson();
  }

  /**
   * Reemail Contact with new [email].
   */
  reemail(String inEmail) {
    _email.text = inEmail;
    _editEmail.setValue(inEmail);
    _displayPerson();
  }
  
  /**
   * Mark [widget] attached to RootPanel and remember it for cleanup.
   */
  void _attachToRootPanel(ui.Widget widget) {
    widget.onAttach();
    ui.RootPanel.detachOnWindowClose(widget);
  }
}