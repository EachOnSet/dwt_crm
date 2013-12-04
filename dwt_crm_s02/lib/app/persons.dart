part of dwt_crm_app;

/**
 * Composite shows Todo components.
 */
class Persons extends ui.VerticalPanel implements ActionReactionApi {
  ContactApp _contactApp;

  /**
   * Create new instance of [Persons].
   */
  Persons(this._contactApp) {
    _contactApp.domain.startActionReaction(this);
    _load(_contactApp.contacts);

    addStyleName('todos');
  }

  /**
   * Load list of contact as JSON string, deserialize and create Person components.
   */
  _load(Contacts contacts) {
    String json = window.localStorage['crm-dartling-dwt'];
    if (json != null && json != "[]") {
      try {
        var countactsCount = contacts.count;
        for (int i=countactsCount; i > 0;i--){
          contacts.remove(contacts.internalList.elementAt(i-1));
        }
        contacts.fromJson(JSON.decode(json));
        for (Contact contact in contacts) {
          _add(contact);
        }
      } on Exception catch(e) {
        print(e);
      }
    } else if (contacts.count > 0) {
      for (Contact contact in contacts) {
        _add(contact);
      }
    } else {
      //Nothing to add, not supposed to arrive here
    }
  }

  /**
   * Add [contact] as Person presentation.*/
  _add(Contact contact) {
    var person = new Person(_contactApp, contact);
    person.delete(contact.deleted);
    add(person);
  }

  /**
   * Find [contact] between Person components and return as Person class instance.
   */
  Person _find(Contact contact) {
    for (int i = 0; i < getWidgetCount(); i++) {
      Person person = getWidgetAt(i);
      if (person.contact == contact) {
        return person;
      }
    }
  }

  /**
   * Find Person by [contact] and mark it as deleted.
   */
  _delete(Contact contact) {
    var person = _find(contact);
    if (person != null) {
      person.delete(contact.deleted);
    }
  }

  /**
   * Find Contact and rename based on [contact.name].
   */
  _rename(Contact contact) {
    var person = _find(contact);
    if (person != null) {
      person.rename(contact.name);
    }
  }
  
  /**
   * Find Contact and rephone based on [contact.phone].
   */
  _rephone(Contact contact) {
    var person = _find(contact);
    if (person != null) {
      person.rephone(contact.phone);
    }
  }
  
  /**
   * Find Contact and reemail based on [contact.email].
   */
  _reemail(Contact contact) {
    var person = _find(contact);
    if (person != null) {
      person.reemail(contact.email);
    }
  }

  /**
   * Find Person by [contact] and remove from list of components.
   */
  _remove(Contact contact) {
    var person = _find(contact);
    if (person != null) {
      remove(person);
    }
  }

  /**
   * Display all Todo components.
   */
  displayAll() {
    for (int i = 0; i < getWidgetCount(); i++) {
      Person person = getWidgetAt(i);
      person.visible = true;
    }
  }

  /**
   * Display only non-deleted Persons.
   */
  displayLeft() {
    for (int i = 0; i < getWidgetCount(); i++) {
      Person person = getWidgetAt(i);
      if (person.contact.left) {
        person.visible = true;
      } else {
        person.visible = false;
      }
    }
  }
  
  /**
   * Display only completed Todos.
   */
  displayCompleted() {
    for (int i = 0; i < getWidgetCount(); i++) {
      Person person = getWidgetAt(i);
      if (person.contact.deleted) {
        person.visible = true;
      } else {
        person.visible = false;
      }
    }
  }

  /**
   * React by [action].
   */
  react(ActionApi action) {
    updatePerson(SetAttributeAction action) {
      if (action.property == 'deleted') {
        _delete(action.entity);
      } else if (action.property == 'name') {
        _rename(action.entity);
      } else if (action.property == 'phone') {
        _rephone(action.entity);
      } else if (action.property == 'email') {
        _reemail(action.entity);
      }
    }

    if (action is Transaction) {
      for (var transactionAction in action.past.actions) {
        if (transactionAction is SetAttributeAction) {
          updatePerson(transactionAction);
        } else if (transactionAction is RemoveAction) {
          if (transactionAction.undone) {
            _add(transactionAction.entity);
          } else {
            _remove(transactionAction.entity);
          }
        } else if (transactionAction is AddAction) {
          if (transactionAction.undone) {
            _remove(transactionAction.entity);
          } else {
            _add(transactionAction.entity);
          }
        }
      }
    } else if (action is AddAction) {
      if (action.undone) {
        _remove(action.entity);
      } else {
        _add(action.entity);
      }
    } else if (action is RemoveAction) {
      if (action.undone) {
        _add(action.entity);
      } else {
        _remove(action.entity);
      }
    } else if (action is SetAttributeAction) {
      updatePerson(action);
    }
    _contactApp.updateDisplay();
    _contactApp.save();
  }
}

