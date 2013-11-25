part of dwt_crm_app;

/**
 * Footer composite component.
 */
class Footer extends ui.Composite {
  Contacts _contacts;

  Persons _persons;
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
    ui.Grid grid = new ui.Grid(1, 3);
    grid.setCellPadding(2);
    grid.addStyleName('footer');
    grid.getRowFormatter().setVerticalAlign(
      0, i18n.HasVerticalAlignment.ALIGN_MIDDLE);
    initWidget(grid);

    grid.addStyleName('footer');
    
    // Get #todo-count from page
    _leftCount = new ui.InlineHtml();
    grid.setWidget(0, 0, _leftCount);
    
    _selection = new ui.ListBox();
    _selection.addItem('All');
    _selection.addItem('Active');
    _selection.addItem('Deleted');
    _selection.addChangeHandler(new event.ChangeHandlerAdapter(
      (event.ChangeEvent event) {
        _updateSelectionDisplay();
      })
    );
    _selection.addStyleName('selection-list-box');
    grid.setWidget(0, 1, _selection);
    
    // Get #clear-completed from page
    _clearDeleted = new ui.Button(
      'Clear completed', new event.ClickHandlerAdapter((event.ClickEvent e) {
        var transaction = new Transaction('clear-completed', session);
        for (Contact contact in _contacts.deleted) {
          transaction.add(
            new RemoveAction(session, _contacts.deleted, contact));
        }
        transaction.doit();
      })
    );
    _clearDeleted.addStyleName('todo-button');
    grid.setWidget(0, 2, _clearDeleted);
  }
  
  /**
   * Update selection display base on [History] token information.
   */
  _updateSelectionDisplay() {
    int index = _selection.getSelectedIndex();
    if (index == 0) {
      _persons.displayAll();
    } else if (index == 1) {
      _persons.displayLeft();
    } else if (index == 2) {
      _persons.displayCompleted();
    }
  }

  /**
   * Update information in all corresponding elements on page.
   */
  updateDisplay() {
    var allLength = _contacts.length;
    visible = true;
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
  }
}