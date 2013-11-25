part of dwt_crm_app;

/**
 * Footer composite component.
 */
class Footer extends ui.Composite {
  Contacts _contacts;

  Persons _persons;
  ui.HtmlPanel _footer;
  ui.InlineHtml _leftCount;
  ui.ListBox _selection;
  ui.Button _clearDeleted;

  /**
   * Create new instance of [Footer] component.
   */
  Footer(ContactApp contactApp, this._persons) {
    DomainSession session = contactApp.session;
    _contacts = contactApp.contacts;

    // Get #footer from page
    _footer = new ui.HtmlPanel.wrap(querySelector("#footer"));
    initWidget(_footer);
    
    // Get #todo-count from page
    _leftCount = new ui.InlineHtml.wrap(querySelector("#todo-count"));
    
    // Get #clear-completed from page
    _clearDeleted = new ui.Button.wrap(querySelector("#clear-completed"));
    _clearDeleted.addClickHandler(new event.ClickHandlerAdapter((event.ClickEvent e) {
        var transaction = new Transaction('clear-completed', session);
        for (Contact contact in _contacts.deleted) {
          transaction.add(
            new RemoveAction(session, _contacts.deleted, contact));
        }
        transaction.doit();
      }));

    // Add History event handler
    ui.History.addValueChangeHandler(new event.ValueChangeHandlerAdapter((event.ValueChangeEvent evt){
      //_updateSelectionDisplay();
    }));
  }
  
  /**
   * Update selection display base on [History] token information.
   */
  _updateSelectionDisplay() {
    String token = ui.History.getToken();
    if (token == "/active") {
      _persons.displayLeft();
      _selectNavigation(token);
    } else if (token == "/completed") {
      _persons.displayCompleted();
      _selectNavigation(token);
    } else {
      _persons.displayAll();
      _selectNavigation("/");
    }
  }

  /**
   * Select active navigation element based on [token].
   */
  void _selectNavigation(String token) {
    List<AnchorElement> anchors = querySelectorAll("#filters li a");
    if (anchors != null) {
      anchors.forEach((AnchorElement anchor){
        ui.Anchor a = new ui.Anchor.wrap(anchor);
        if (a.href.endsWith(token)) {
          a.addStyleName("selected");
        } else {
          a.removeStyleName("selected");
        }
      });
    }
  }

  /**
   * Update information in all corresponding elements on page.
   */
  updateDisplay() {
    var allLength = _contacts.length;
    if (allLength > 0) {
      _footer.visible = true;
      var completedLength = _contacts.deleted.length;
      var leftLength = _contacts.left.length;
      _leftCount.html = '<strong>${leftLength}</strong> contact${leftLength != 1 ? 's' : ''}';

      _updateSelectionDisplay();

      if (completedLength == 0) {
        _clearDeleted.visible = false;
      } else {
        _clearDeleted.visible = true;
      }
      _clearDeleted.text = 'Clear deleted (${completedLength})';
    } else {
      _footer.visible = false;
    }
  }
}