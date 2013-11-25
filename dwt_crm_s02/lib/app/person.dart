part of dwt_crm_app;

/**
 * Todo composite component.
 */
class Person extends ui.Composite {
  Contact contact;

  ui.CheckBox _completed;
  ui.Label _name;
  ui.Label _email;
  ui.Label _phone;
  ui.Button _remove;
  ui.Grid _grid;

  /**
   * Create an instance of [Person].
   */
  Person(ContactApp todoApp, this.contact) {
    DomainSession session = todoApp.session;
    Contacts contacts = todoApp.contacts;

    _grid = new ui.Grid(1, 5);
    _grid.setCellSpacing(8);
    _grid.addStyleName('todo');
    _grid.getRowFormatter().setVerticalAlign(
        0, i18n.HasVerticalAlignment.ALIGN_MIDDLE);
    initWidget(_grid);

    // Completed CheckBox
    _completed = new ui.CheckBox();
    _completed.setValue(contact.deleted);
    _completed.addValueChangeHandler(new event.ValueChangeHandlerAdapter(
      (event.ValueChangeEvent e) {
        new SetAttributeAction(session, contact, 'deleted',
          !contact.deleted).doit();
      })
    );
    _grid.setWidget(0, 0, _completed);

    // Labels
    _name = new ui.Label();
    _name.text = contact.name;
    _name.addStyleName('todo');
    _phone = new ui.Label();
    _phone.text = contact.phone;
    _phone.addStyleName('todo');
    _email = new ui.Label();
    _email.text = contact.email;
    _email.addStyleName('todo');
    
    // Gen
    var person_rename = new ui.TextBox();
    person_rename.text = _name.text;
    person_rename.addStyleName('todo retitle');
    var person_rephone = new ui.TextBox();
    person_rephone.text = _phone.text;
    person_rephone.addStyleName('todo retitle');
    var person_reemail = new ui.TextBox();
    person_reemail.text = _phone.text;
    person_reemail.addStyleName('todo retitle');
    var newName = person_rename.text;
    var newPhone = person_rephone.text;
    var newEmail = person_reemail.text;
    var otherTask = contacts.firstWhereAttribute('email', newEmail);
    
    _name.addDoubleClickHandler(
      new event.DoubleClickHandlerAdapter((event.DoubleClickEvent e) {
        _completed.visible = false;
        _remove.visible = false;
        // Name
        person_rename.addKeyPressHandler(new
          event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
          if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
            if (otherTask == null) {
              bool done1 = new SetAttributeAction(
                  session, contact, 'name', newName).doit();
              bool done2 = new SetAttributeAction(
                  session, contact, 'phone', newPhone).doit();
              bool done3 = new SetAttributeAction(
                  session, contact, 'email', newEmail).doit();
              if (!done1 && !done2 && !done3) {
                contacts.errors.clear();
              }
            } else {
              _displayPerson();
              _name.text = newName;
              _phone.text = newPhone;
              _email.text = newEmail;
            }
          } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
            _displayPerson();
          }
        })
      );
      _grid.setWidget(0, 1, person_rename);
      
      // Phone
      person_rephone.addKeyPressHandler(new
        event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
          if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
            if (otherTask == null) {
              bool done1 = new SetAttributeAction(
                  session, contact, 'name', newName).doit();
              bool done2 = new SetAttributeAction(
                  session, contact, 'phone', newPhone).doit();
              bool done3 = new SetAttributeAction(
                  session, contact, 'email', newEmail).doit();
              if (!done1 && !done2 && !done3) {
                contacts.errors.clear();
              }
            } else {
              _displayPerson();
              _name.text = newName;
              _phone.text = newPhone;
              _email.text = newEmail;
            }
          } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
            _displayPerson();
          }
        })
      );
      _grid.setWidget(0, 2, person_rephone);
      
      // Email
      person_reemail.addKeyPressHandler(new
        event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
          if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
            if (otherTask == null) {
              bool done1 = new SetAttributeAction(
                  session, contact, 'name', newName).doit();
              bool done2 = new SetAttributeAction(
                  session, contact, 'phone', newPhone).doit();
              bool done3 = new SetAttributeAction(
                  session, contact, 'email', newEmail).doit();
              if (!done1 && !done2 && !done3) {
                contacts.errors.clear();
              }
            } else {
              _displayPerson();
              _name.text = newName;
              _phone.text = newPhone;
              _email.text = newEmail;
            }
          } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
            _displayPerson();
          }
        })
      );
      _grid.setWidget(0, 3, person_reemail);
      })
    );
    
    _phone.addDoubleClickHandler(
        new event.DoubleClickHandlerAdapter((event.DoubleClickEvent e) {
          _completed.visible = false;
          _remove.visible = false;
          // Name
          person_rename.addKeyPressHandler(new
              event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
                if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
                  if (otherTask == null) {
                    bool done1 = new SetAttributeAction(
                        session, contact, 'name', newName).doit();
                    bool done2 = new SetAttributeAction(
                        session, contact, 'phone', newPhone).doit();
                    bool done3 = new SetAttributeAction(
                        session, contact, 'email', newEmail).doit();
                    if (!done1 && !done2 && !done3) {
                      contacts.errors.clear();
                    }
                  } else {
                    _displayPerson();
                    _name.text = newName;
                    _phone.text = newPhone;
                    _email.text = newEmail;
                  }
                } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
                  _displayPerson();
                }
              })
          );
          _grid.setWidget(0, 1, person_rename);
          
          // Phone
          person_rephone.addKeyPressHandler(new
              event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
                if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
                  if (otherTask == null) {
                    bool done1 = new SetAttributeAction(
                        session, contact, 'name', newName).doit();
                    bool done2 = new SetAttributeAction(
                        session, contact, 'phone', newPhone).doit();
                    bool done3 = new SetAttributeAction(
                        session, contact, 'email', newEmail).doit();
                    if (!done1 && !done2 && !done3) {
                      contacts.errors.clear();
                    }
                  } else {
                    _displayPerson();
                    _name.text = newName;
                    _phone.text = newPhone;
                    _email.text = newEmail;
                  }
                } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
                  _displayPerson();
                }
              })
          );
          _grid.setWidget(0, 2, person_rephone);
          
          // Email
          person_reemail.addKeyPressHandler(new
              event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
                if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
                  if (otherTask == null) {
                    bool done1 = new SetAttributeAction(
                        session, contact, 'name', newName).doit();
                    bool done2 = new SetAttributeAction(
                        session, contact, 'phone', newPhone).doit();
                    bool done3 = new SetAttributeAction(
                        session, contact, 'email', newEmail).doit();
                    if (!done1 && !done2 && !done3) {
                      contacts.errors.clear();
                    }
                  } else {
                    _displayPerson();
                    _name.text = newName;
                    _phone.text = newPhone;
                    _email.text = newEmail;
                  }
                } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
                  _displayPerson();
                }
              })
          );
          _grid.setWidget(0, 3, person_reemail);
        })
    );
    
    _email.addDoubleClickHandler(
        new event.DoubleClickHandlerAdapter((event.DoubleClickEvent e) {
          _completed.visible = false;
          _remove.visible = false;
          // Name
          person_rename.addKeyPressHandler(new
              event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
                if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
                  if (otherTask == null) {
                    bool done1 = new SetAttributeAction(
                        session, contact, 'name', newName).doit();
                    bool done2 = new SetAttributeAction(
                        session, contact, 'phone', newPhone).doit();
                    bool done3 = new SetAttributeAction(
                        session, contact, 'email', newEmail).doit();
                    if (!done1 && !done2 && !done3) {
                      contacts.errors.clear();
                    }
                  } else {
                    _displayPerson();
                    _name.text = newName;
                    _phone.text = newPhone;
                    _email.text = newEmail;
                  }
                } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
                  _displayPerson();
                }
              })
          );
          _grid.setWidget(0, 1, person_rename);
          
          // Phone
          person_rephone.addKeyPressHandler(new
              event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
                if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
                  if (otherTask == null) {
                    bool done1 = new SetAttributeAction(
                        session, contact, 'name', newName).doit();
                    bool done2 = new SetAttributeAction(
                        session, contact, 'phone', newPhone).doit();
                    bool done3 = new SetAttributeAction(
                        session, contact, 'email', newEmail).doit();
                    if (!done1 && !done2 && !done3) {
                      contacts.errors.clear();
                    }
                  } else {
                    _displayPerson();
                    _name.text = newName;
                    _phone.text = newPhone;
                    _email.text = newEmail;
                  }
                } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
                  _displayPerson();
                }
              })
          );
          _grid.setWidget(0, 2, person_rephone);
          
          // Email
          person_reemail.addKeyPressHandler(new
              event.KeyPressHandlerAdapter((event.KeyPressEvent e) {
                if (e.getNativeKeyCode() == event.KeyCodes.KEY_ENTER) {
                  if (otherTask == null) {
                    bool done1 = new SetAttributeAction(
                        session, contact, 'name', newName).doit();
                    bool done2 = new SetAttributeAction(
                        session, contact, 'phone', newPhone).doit();
                    bool done3 = new SetAttributeAction(
                        session, contact, 'email', newEmail).doit();
                    if (!done1 && !done2 && !done3) {
                      contacts.errors.clear();
                    }
                  } else {
                    _displayPerson();
                    _name.text = newName;
                    _phone.text = newPhone;
                    _email.text = newEmail;
                  }
                } else if (e.getNativeKeyCode() == event.KeyCodes.KEY_ESCAPE) {
                  _displayPerson();
                }
              })
          );
          _grid.setWidget(0, 3, person_reemail);
        })
    );
    
    _grid.setWidget(0, 1, _name);
    _grid.setWidget(0, 2, _phone);
    _grid.setWidget(0, 3, _email);

    // Remove button
    _remove = new ui.Button(
      'X', new event.ClickHandlerAdapter((event.ClickEvent e) {
        new RemoveAction(session, contacts, contact).doit();
      })
    );
    _remove.addStyleName('todo-button remove');
    _grid.setWidget(0, 4, _remove);
  }

  /**
   * Change style depends on task [completed] status.
   */
  delete(bool deleted) {
    _completed.setValue(deleted);
    if (deleted) {
      _name.addStyleName('completed');
      _phone.addStyleName('completed');
      _email.addStyleName('completed');
    } else {
      _name.removeStyleName('completed');
      _phone.removeStyleName('completed');
      _email.removeStyleName('completed');
    }
  }

  /**
   * Remove editing style from element.
   */
  _displayPerson() {
    _completed.visible = true;
    _remove.visible = true;
    _grid.setWidget(0, 1, _name);
    _grid.setWidget(0, 2, _phone);
    _grid.setWidget(0, 3, _email);
  }

  /**
   * Rename Contact with new [name].
   */
  rename(String inName) {
    _name.text = inName;
    _displayPerson();
  }
  
  /**
   * Rephone Contact with new [phone].
   */
  rephone(String inPhone) {
    _phone.text = inPhone;
    _displayPerson();
  }

  /**
   * Reemail Contact with new [email].
   */
  reemail(String inEmail) {
    _email.text = inEmail;
    _displayPerson();
  }
}