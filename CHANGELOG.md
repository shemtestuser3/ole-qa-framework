### v2.1.0 - 2013/07/??

* Login/Logout
    * Added .login(username) & .logout to OLE_QA::Framework::Page_Helpers
        * .login attempts to login with given username string
            * returns true if successful, false if not
            * raises OLE_QA::Framework::Error if login field not found
        * .logout attempts to logout
            * returns true if successful, false if not
        * both methods use @browser instance variable instead of  browser
        function, as the login field is never found within iframeportlet.
* Open Method
    * Added .open(url) to OLE_QA::Framework::Session
        * opens the given URL, defaults to @base_url
* Custom Error Class
    * Added OLE_QA::Framework::Error class (inherits StandardError).

### v2.0.4 - 2013/07/05

* .function - alias for .set_function
* Common Object class added
    * The Common Object class is inherited by both Page & Data Object classes in order
        to perform a DRYer initialize for both.

### v2.0.3 - 2013/07/05

* .elements & .functions methods on Page & Data Objects
    * elements and functions defined on Page and Data Objects are automatically added
        to the .elements and .functions array accessor methods, respectively.
* .set_function
    * defines a function in the same manner as an element - a lambda to be evaluated
        which represents a set of actions to be taken in sequence by the browser.

### v2.0.2 - 2013/07/05

* Wait Constants -> Wait Reader Attributes
    * .explicit_wait & .doc_wait still set from options, but now exist as reader
        attributes on the OLE_QA::Framework module.

### v2.0.1 - 2013/07/05

* Wait Constants in OLE_QA::Framework Namespace
    * Explicit_Wait -> explicit_wait option
    * Doc_Wait -> doc_wait option

### v2.0.0 - 2013/07/03

* Namespace Refactoring
    * Main namespace has been changed from OLE_QA to OLE_QA::Framework.
    * Main session-handling class has been renamed to OLE_QA::Framework::Session.
    * Constants VERSION and COMPATIBILITY have been moved to OLE_QA::Framework.
    * Main Menu classes moved to OLEFS & OLELS namespaces under OLE_QA::Framework.
* OLELS
    * Added Describe Workbench page

### v1.0.0 - 2013/06/24

* Watir-Webdriver
    * The entire project has been refactored to use Watir-Webdriver.
* ole-qa-framework.rb
    * Renamed from ole_qa_framework.rb
    * Spec renamed
    * Module renamed from OLE_QAF to OLE_QA
    * now loads version info programmatically
        * lib/ole_qa_framework/VERSION.rb
        * lib/ole_qa_framework/COMPATIBILITY.rb
    * loads subdirectories in order of dependency, files in alphabetical order
    * added .fs_url method, returns @base_url
    * refactored configuration files
        * implicit_wait is now set to 0 by default for Watir compatibility
* modules
    * rewrites to
        * qa_helpers.rb
            * contains .set_element for data objects and page objects
                * expects an element name, an element type, a how, and a what
                * creates an instance variable and an accessor on self
                * allows for extension of element definitions in data & page objects
                * allows to optionally redefine a previously-defined element on self with force option
            * contains .set_elements for data objects and page objects
                * expects a nested array of element definitions
                * populates elements as instance variables on self
                * uses .set_element for individual elements
        * qa_data_helpers.rb
            * contains .load_elements for data objects
            * contains .replace_identifiers for line/subline objects
        * qa_page_helpers.rb
            * contains .load_elements for page objects

---------------------------------------------------------------------------------------------------------
    *HISTORICAL* - Below this point, the information in this changelog may no longer
    be applicable, as it pertains to the previous Selenium-WebDriver based version of
    this testing framework.

    ### v0.8.0 - 2013/06/07

    * Instance Editor (OLELS)
        * Create Instance Editor Page
            * Ownership Extent Line
                * Ownership Note Line
            * Access Info Line
            * Holdings Note Line
        * Create Editor Note Line Object
            * "Access Info" Note Type
            * "Holdings Note" Note Type
            * "Ownership Note" Note Type
    * Item Editor
        * Create Item Editor Page
            * Item Note Line Object
        * Create Editor Note "Item Note" Type

    ### v0.7.0 - 2013/06/06

    * Remodel Line Object & Subline Object Handling in PURAP Documents
        * Remove .add_line methods
            * .add_button will need to be clicked manually
            * Line Objects & Subline Objects will be noted as new or added upon
            instantiation.  The default will be "new".
                * new.yml - will still contain element definitions not needing
                line number, line identifier, subline number, and subline identifier
                substitution
                * added.yml - will still contain element definitions needing line
                number, line identifier, subline number, and subline identifier
                substitution
                * conversion will not occur automatically between the two sets of
                identifiers; instead, a new instance will need to be created to
                represent the item after it has been added
                * this functionality is more accurate in that adding a line on a
                PURAP document will always populate the added line and retain a new
                line, which will always have value-independent identifiers
        * Replace nested object handling methods
            * Replace .remove_X_line(which, do_click) with .delete_X_line
                * the .delete_button will need to be clicked manually if it exists
                * this further separates the page model from the behavior of the actual
                page on the screen in order to allow users to remove inappropriate lines
                from the model
                * delete_X_line
                    * delete the highest instance variable representing a line item or
                    subline item of X type (e.g., .delete_line_item will remove
                    .line_item_N from a PURAP document's model)
                    * decrement the appropriate .X_line_counter variable
            * Replace .add_X_line(do_click) with .create_X_line
                * the .add_button will need to be clicked manually if it exists and
                needs to be clicked
                * this further separates the page model from the behavior of the actual
                page on the screen in order to allow users to create lines on the page
                model when they are expected to already exist on the actual document being
                modeled (e.g., when a Purchase Order is opened, this will facilitate
                the creation of both line items and accounting lines to match the expected
                shape of the Purchase Order on the screen)
                * create_X_line
                    * increment the appropriate .X_line_counter variable
                    * create a new instance variable representing a line item or subline
                    item of X type (e.g., .create_accounting_line will create a new
                    .accounting_line_N where N = .accounting_line_counter + 1)
            * Using "create" and "delete" instead of "add" and "remove" should make it clearer
            that the new functionality refers to instances on the page model rather than items
            on the actual page itself.
        * Instantiate new pages with .new_X_line instead of .X_line_1, where X is a line object
        type
        * Instantiate new line objects with .new_X_line instead of .X_line_1, where X is a
        subline object type

    ### v0.6.0 - 2013/06/05

    * Rename Requisition File
        * lib/olefs/pages/requisition.rb -> lib/olefs/pages/purap_requisition.rb
        * lib/olefs/pages/requisition/ -> lib/olefs/pages/purap_requisition/
        * These changes were made so that purchase order definitions & functionality
          can be inherited from requisitions (load order is alphabetic).
    * New Data Objects
        * Receiving Line
            * Line Object
            * About
                * Represents a single Receiving Line on a Receiving Document
                * Analogous in behavior to Line Item on Requisition and Purchase Order
                * Can be added, but cannot be deleted
                    * the function is not supported in OLE -- there is no delete button
                    for a newly-added Receiving Line
                * Has receiving-related notes lines, but no accounting lines
                * The only common subline is the copies line
                * Even if the related line item has no copies line and the # of copies is
                1 for a given item, the copies line is required on the receiving line
            * Fields
                * description field
                * quantity ordered field
                * parts ordered field
                * prior quantity received field
                    * (not available on new receiving line)
                * prior parts received field
                    * (not available on new receiving line)
                * quantity to be received field
                * parts to be received field
                * item received quantity field
                * item received parts field
                * item returned quantity field
                * item returned parts field
                * item damaged quantity field
                * item damaged parts field
                * available to public checkbox
                    * public view checkbox (alias)
            * Methods
                * add_line
                * add sublines
                    * add_exception_notes_line
                    * add_receipt_notes_line
                    * add_processing_line
                    * add_copies_line
                * remove sublines
                    * remove_exception_notes_line
                    * remove_receipt_notes_line
                    * remove_processing_line
                    * remove_copies_line
                * counters
                    * exception_notes_line_counter
                    * receipt_notes_line_counter
                    * processing_line_counter
                    * copies_line_counter
        * Exception Notes Line
            * Subline Object
            * Fields
        * Receipt Notes Line
            * Subline Object
            * Fields
        * Processing Line
            * About
                * Represents a subline item for Special Processing Instructions
                added as a special Note Type on a requisition or purchase order
                Notes Line.
                * Cannot be added or removed on the Receiving Line.
                * Retains an .add_line method for consistency.  Use .add_line to
                create the object to represent an existing Special Processing
                Instructions Note line on the Receiving Line.  There is no
                .add_button or .delete_button element to click, so .add_line
                is permanently aliased to do .add_line(do_click = false).
            * Subline Object
            * Fields
                * note field
                * acknowledge checkbox
        * PREQ Line Item
            * About
                * Represents a special line item for payment requests only
            * Line Object
            * Fields
                * po_unit_price_field
                * format_selector
                * vendor_item_identifier_field
                * number_of_copies_ordered_field
                * number_of_parts_ordered_field
                * list_price_field
                * discount_field
                * discount_type_selector
                * assigned_to_trade_in_checkbox
                    * becomes assigned_to_trade_in_field when added
                * description_field
                * receipt_status_selector
                * new_bib_button
                    * becomes edit_bib_button when added
        * Invoice Notes Line
            * About
                * Represents a special type of notes line for payment requests
                only
            * Subline Object
            * Fields
                * note_field
    * New Pages
        * Purchase Order
            * Inheritance
                * Page -> OLEFS E-Doc -> Requisition -> Purchase Order
            * Fields
                * Purchase Order Detail Area
                    * funding source selector
                * Vendor Tab
                    * vendor name field
                        * redefined from requisition
                * View View Related Docs Tab
                    * view related requisition link
                * Input Buttons
                    * sensitive data button
                    * payment hold button
                    * amend button
                    * void order button
                    * receiving button
                    * print button
                    * send ad hoc button
            * NB - Functionality is largely established by requisition.
            See notes in YARD Documentation on Purchase Order class for more
            information about how a Purchase Order can be modeled appropriately
            for different OLE workflows.
        * PURAP Document
            * Inheritance
                * Page -> OLEFS E-Doc -> PURAP Document
            * Fields
                * Route Log Tab
                    * route log tab toggle
                    * actions taken array
                    * actions taken by array
            * Methods
                * add_line_item
                * remove_line_item
            * Purpose
                * The Line Item methods were moved from the Requisition document
                page to the PURAP document page so that they could be inherited by
                multiple document types.
        * Receiving Document
            * Inheritance
                * Page -> OLEFS E-Doc -> PURAP Document -> Receiving Document
            * Fields
                * Vendor Tab
                    * vendor tab toggle
                    * date received field
                    * packing slip number field
                    * bill of lading number field
                    * reference number field
                    * carrier selector
                * Delivery Tab
                    * delivery tab toggle
                    * campus field
                    * building field
                    * address field
                    * room field
                    * city field
                    * state field
                    * postal code field
                    * country field
                    * delivery to field
                    * phone number field
                    * email field
                * View Related Documents Tab
                    * view related documents tab toggle
                    * view related po link
                    * view related requisition link
            * Methods
                * add_receiving_line
                * remove_receiving_line
                * receiving_line_counter
            * About
                * The Receiving Document uses a different type of item line.
                Instead of the Line Item, Line Items are represented by Receiving
                Lines.  A document begins with at least one full receiving line,
                so the Receiving Document class creates two receiving lines upon
                instantiation - one added, and one new.  Like the Requisition and
                Purchase Order classes, the highest receiving line number will always
                point at the new line to-be-added.
        * Payment Request
            * Inheritance
                * Page -> OLEFS E-Doc -> PURAP Document -> Payment Request
            * Fields
                * Invoice Info Tab
                    * invoice_number_field
                    * pay_date_field
                    * invoice_date_field
                    * immediate_pay_checkbox
                    * payment_attachment_checkbox
                    * invoice_type_field
                    * invoice_subtype_field
                    * payment_method_selector
                * Titles Tab
                    * grand_total_field
                    * additional_charges_toggle
                    * freight_extended_cost_field
                    * freight_description_field
                    * shipping_handling_extended_cost_field
                    * shipping_handling_description_field
                    * minimum_order_extended_cost_field
                    * minimum_order_description_field
                    * miscellaneous_overhead_extended_cost_field
                    * miscellaneous_overhead_description_field
                    * prorate_by_quantity_checkbox
                    * prorate_by_dollar_checkbox
                    * prorate_manual_checkbox
                    * close_po_checkbox
                * View Related Docs Tab
                    * view_related_tab_toggle
                    * view_related_requisition_link
                    * view_related_po_link
            * Methods
                * add_line_item
                * remove_line_item
            * About
                * The Payment Request uses line item objects similar to those on the
                requisition and purchase order, but with different fields, or some fields
                in different locations, and so uses its own class of line item:
                OLE_QA::OLEFS::PREQ_Line_Item.
                * The PREQ Line Item only features two types of sublines:
                    * accounting lines
                    * invoice notes lines
    * New Features
        * Line Object click option
            * In all subclasses of Line Object, the option (do_click) has been added
            to the .add_line and .remove_line methods.  If do_click is set to true
            (default value in most cases) then the test script will attempt to click
            the .add_button or .delete_button element on a given line object.  This
            option is backwards-compatible, and has been included in order to allow more
            accurate modeling of existing line items on new OLEFS PURAP documents, as
            purchase orders, receiving documents, and payment request documents come with
            prepopulated line items.
        * Subline Object click option
            * In all subclasses of Subline Object, the option (do_click) has been
            added to the .add_line and .remove_line methods.  If do_click is set to
            true (default value in most cases) then the test script will attempt to click
            the .add_button or .delete_button element on a given subline object.  This
            option is backwards-compatible, and has been included to give more accuracy
            in modeling PURAP document line items which might include multiple subline
            objects at document creation.

    ### v0.5.0 - 2013/05/30

    * Main Testing Framework Class
        * Renamed, OLE_QA::OLE_Framework -> OLE_QA::Framework
        * Removed .doc_route_wait (this will be handled by OLE_QAT)
        * Removed requirements for Chronic and Benchmark (to be handled by OLE_QAT)
    * YARD
        * Added development dependency for YARD
        * Added formatted comments for YARD Documentation to most complete base classes.
    * New Data Objects
        * Subline Object
            * Created base class and element definitions
            * Used as a nested line, e.g. for an accounting line in OLE Financial System
            * Subclass of Line Object
            * .add_line
                * clicks "add_button" if defined
                * parses element hashes, removes original elements, adds redefined elements
            * Created example element definitions in lib/common/subline_object/
                * new.yml - element definitions before adding
                * added.yml - element definitions after adding
            * Element definitions undergo two rounds of replacement
                * LINEID/LINENUM in identifiers are replaced by Line Item values
                * SUBLINEID/SUBLINENUM in identifiers are replaced by relevant Sub Line values
        * Accounting Line
            * Now a subclass of Subline Object
            * Definitions in
                * lib/OLEFS/objects/accounting_line/
                    * new.yml
                    * added.yml
            * .add_line (from subline object)
            * fields for:
                * chart code
                * account number
                * sub-account
                * object code
                * sub-object
                * org ref id
                * dollar amount
                * percentage
        * Copies Line
            * subclass of Subline Object
            * Definitions in
                * lib/OLEFS/objects/copies_line/
                    * new.yml
                    * added.yml
            * fields for:
                * copies
                * starting copy
                * location copies
        * Notes Line
            * subclass of Subline Object
            * Definitions in
                * lib/OLEFS/objects/notes_line/
                    * new.yml
                    * added.yml
            * fields for:
                * note type
                * note
        * Line Item
            * Line Object
                * represents a single line item on an OLEFS PURAP Document
                * contains sub-objects:
                    * Accounting Line
                    * Copies Line
                    * Notes Line
                * has counters for
                    * accounting lines
                    * copies lines
                    * notes lines
                * has add & remove functionality for each sub-object listed above
                    * add_X_line
                        * clicks the add button on the highest-numbered X line
                        * invokes add_line function on that line to switch from "new" to "added" definitions
                        * advances counter
                    * remove_X_line(N)
                        * clicks the delete button on the Nth line of X type
                        * decrements the counter
                        * resets the highest line of X type to a new, non-added line
                * starts out with:
                    * accounting_line_1
                    * copies_line_1
                    * notes_line_1
                    * all counters set to 1
                * NB - the number of a sub-object line (e.g. the 1 in accounting_line_1)
                  represents the number of line after it is added; the highest numbered
                  line therefore will always point at the new line at the top of the sub-tab,
                  as there is always a new line of any given type there
            * Definitions in
                * lib/OLEFS/objects/line_item
            * Has fields for:
                * number of copies
                * number of parts
                * list price
                * discount
                * item price source
                * request source
                * item type
                * format
                * category
                * discount type
                * public view
                * route to requestor
                * requestor id
                * extended cost
                * unit cost
            * has button/link to current bib
            * has tab toggles for
                * accounting lines
                * copies
                * notes
    * New Pages
        * OLEFS Lookup Page (base class)
           * Inheritance
               * Page -> Lookup
           * Fields
               * title
               * active indicator yes
               * active indicator no
               * active indicator both
               * search button
               * clear button
               * cancel button
        * Requisition
            * Inheritance
                * Page -> OLEFS E-Doc -> Requisition
            * Data Objects
                * Line Item
            * Fields
                * Requisition Detail Area
                    * license request checkbox
                    * receiving required checkbox
                    * payment request approval required checkbox
                * Additional Information Tab
                    * additional info tab toggle
                    * phone number field
                * Delivery Tab
                    * delivery tab toggle
                    * building field
                    * room field
                    * building search icon
                    * campus search icon
                * Vendor Tab
                    * vendor tab toggle
                    * vendor name field
                    * vendor name added field
                    * vendor search icon
                * Titles Tab
                    * grand total field
                * View Related Docs Tab
                    * view related tab toggle
                    * view related po link
            * Methods
                * add_line_item
                    * Adds a line item
                    * Increments the line_item_counter instance variable
                * remove_line_item(which)
                    * Removes a target line item by clicking the delete button
                    * Deletes the highest line item instance variable
                    * Resets the next-highest line item to have new line elements
                    * blocks if target line is highest line (and therefore unadded)
                    * blocks if target line is higher than line item counter
        * Vendor Lookup
            * Inheritance
                * Page -> OLEFS Lookup -> Vendor Lookup
            * Fields
                * vendor name field
                * tax number field
                * vendor number field
                * vendor type selector
                * state field
                * commodity code field
                * supplier diversity selector
        * Building Lookup
            * Inheritance
                * Page -> OLEFS Lookup -> Building Lookup
            * Fields
                * campus code field
                * building code field
                * building name field

    ### v0.4.0 - 2013/05/03

    * Data Helpers
        * .replace_identifiers
            * given an element hash, replace identifier strings in hash with dynamic values
        * .replace_names
            * given an element hash, replace the keys in the hash with dynamic values
    * Line Object
        * make use of .replace_identifiers
    * OLEFS E-Doc
        * automatically perform .frame_select upon open
    * Checkbox Element
        * added .check and .uncheck methods
            * these methods will return output in addition to setting or unsetting a checkbox
                * true if successful or unnecessary (depending on previous state)
                * false if unsuccessful
    * Bib Editor Line
        * Represents a line in the OLELS Bib Editor
        * Can represent a Leader Field line, a Control Field line, or a Data Field line
            * dynamically set with line_type variable
            * defaults to 'data'
            * configures elements from yaml_files in lib/olels/objects/bib_editor/
                * leader_line.yml
                * control_line.yml
                * data_line.yml
            * sets the following elements on instances, depending on type
                * value_field (all)
                * tag_field (control & data only)
                * indicator_1_field (data only)
                * indicator_2_field (data only)
                * add_button (control & data only)
                * remove_button (control & data only)
    * Data Element
        * .verify_text
            * now includes text & text.strip verifictions
            * text in OLE is often wrapped with whitespace or newline characters
            * target text will be verified with or without .strip
    * Editor
        * base class for OLELS Describe Editor interfaces
        * has common elements:
            * .submit_button                - submit record
            * .cancel_button                - cancel edits
            * .close_button                 - close record
            * .title                        - title span of current editor
            * .return_to_search_button      - close & return to bib search
    * Bib Editor
        * represents a Marc Bibliographic Record Editor Page
        * native to OLELS, but opens in OLEFS on PURAP documents & DocStore on edit
        * .leader_line
            * data object for leader line consisting of a value field
            * elements:
                * .value_field
        * .control_line_1
            * data object automatically created for first control line
            * elements:
                * .tag_field
                * .value_field
        * .data_line_1
            * data object automatically created for first data line
            * elements:
                * .tag_field
                * .indicator_1_field
                * .indicator_2_field
                * .value_field
        * .control_line_N
            * sequential data objects automatically created or deleted for add'l control lines
        * .data_line_N
            * sequential data objects automatically created or deleted for add'l data lines
        * .add_control_line
            * adds a new control_line_N
            * increments .control_line_counter
        * .add_data_line
            * adds a new data_line_N
            * increments .data_line_counter
        * .remove_control_line(N)
            * removes control_line_N
            * shifts control lines downward
            * decrements .control_line_counter
        * .remove_data_line(N)
            * removes data_line_N
            * shifts data lines downward
            * decrements .data_line_counter
        * .save
            * saves current record with .submit_button
            * increments control lines for addition of automagic control line by OLE
        * .save_message
            * message span for save message

    ### v0.3.2 - 2013/05/01

    * Checkbox Element
       * Added Checkbox Element class
           * .checked? - returns true/false
           * .verify_checked - returns true/false, rescues if element not found
    * Line Object
       * new.yml
           * added all necessary item definitions
    * Requisition
       * URLs
           * fixed definition for [:new] in URLs hash file
    * Spec
       * Made fixes to:
           * Data Object
           * Line Object
    * Page
       * .frame_present?
           * method is no longer private

    ### v0.3.1 - 2013/04/30

    * Line Object
        * new.yml
            * also now undergoes LINENUM/LINEID replacement

    ### v0.3.0 - 2013/04/30

    * Line Object
        * common/
            * Line Object - base class for addable line objects, includes initialize and add_line methods
                * .add_line
                    * clicks self.add if such an element exists
                    * removes previous elements set by new.yml and replaces them with those in added.yml
            * line_object/
                * new.yml - YML definitions file for elements while the line object is still new
                    * uses static definitions for element identifier strings
                    * this is where you would include an .add element
                * added.yml - YML definitions file for elements after the line object has been added
                    * uses dynamic definitions for element identifier strings
                    * these elements will only exist on the line object after .add_line is invoked
        * spec/elements/
            * Line Object Spec
                * tests for class constituency
                * tests for element constituency
                * tests for .add_line functionality
                * uses lib/common/line_object/new.yml & added.yml for testing

    ### v0.2.3a - 2013/04/30

    * Remove Test Pages
        * remove directory & load references
    * Load Modules First
        * altered load order to load modules first; assuming they will not contain WebDriver-dependent methods

    ### v0.2.2b - 2013/04/29

    * Gem Build & Install Successful
        * Completed Gemspec
            * Added dependencies
            * Added development dependency
        * Refactored loading of libraries
            * Verified libraries load after gem install

    ### v0.2.2a - 2013/04/29

    * Now using Version Gem to maintain OLE_QA::VERSION constant
        * ole_qa_framework.gemspec depends on Version
    * Common
        * data_object
            * base class for all Data Objects
            * collection of element definitions below the page level
            * intended for creating recursive data objects
        * line_object
            * special Data Object
            * mostly used by OLEFS PURAP Documents
            * represents a single line in a tab that can be added or removed
            * should have two data files
                * new.yml - for a new data line, where all element IDs are set to 0
                * added.yml - used after data line is added, redefines element IDs dynamically
    * Module
        * qaf_helpers - general module for all helpers
        * qaf_page_helpers - helper module for page objects specifically
            * (currently unused)
        * qaf_data_helpers - helper module for non-page data objects
            * (currently unused)
    * OLEFS
        * e_doc - base page definition for all e-documents in OLE Financial System
        * objects/ - object definitions for OLE Financial System data objects
            * line_item - Used to create a Line Item for any OLEFS Purchasing/AP e-documents
            * accounting_line - Used to create control elements for an Accounting Line on a Line Item
            * copies_line - Used to create control elements for a Copies Line on a Line Item
        * pages/
            * requisition - will be used to create base class for OLEFS PURAP Requisition Document
                * (incomplete)
            * main_menu - used to create definitions for OLEFS Main Menu
                * (incomplete)
    * OLELS
        * e_doc - base page definition for all e-documents in OLE Library System
        * editor - base class for various bibliographic record editors in OLELS
            * (incomplete)
            * must be loaded before each editor is loaded, hence inclusion in OLELS/ instead of pages/
            * will be used by:
                * MARC Editor
                * Holdings Editor
                * Item Editor
        * pages/
            * main_menu - used to create definitions for OLELS Main Menu
                * (incomplete)

    ### v0.2.2 - 2013/04/15

    * YAML Configuration
        * lib/config/default_options.yml
            * Default configurations for OLE QA Framework
            * currently points to OLE Test Environment
        * lib/config/defaults/
            * ole_dev_environment.yml
                * points to OLE Development Environment
            * ole_test_environment.yml
                * points to OLE Test Environment
            * ole_test_no_headless.yml
                * points to OLE Test Environment
                * runs browser without Headless gem (no xvfb session invoked)

    ### v0.2.1 - 2013/04/12

    * Test Pages
        * lib/test_pages defines pages for testing base classes and methods
        * lib/test_pages/kuali_kis
            * Kuali KIS - http://kis.kuali.org/
            * Defines base page class with URL & some elements for spec testing
        * spec/test_pages/kuali_kis_spec
            * Defines spec behaviors for Kuali KIS page for testing

    ### v0.2.0 - 2013/04/11

    * API Change
        * All classes now enclosed within OLE_QA namespace
    * lib/module
        * QAF_Helpers
            * includes mixin methods for dynamically adding attributes to classes

    ### v0.1.1 - 2013/04/10

    * Structure Changes
        * Elements -> Objects
        * Browser
            * includes web_element.rb base class for Selenium web elements
            * includes web_element/ directory for element subclasses
                * data_element.rb - basic class for an element which contains useful data
                * input_element.rb - for input fields and controls
                * selector_element.rb - for drop-down select menus
        * OLEFS
            * Pages
                * main_menu.rb - page class for OLEFS main menu
        * OLELS
            * Pages
                * main_menu.rb - page class for OLELS main menu
     * Additions
        * Rakefile
            * spec namespace for running rspec tests
                * run_all task for running all specs
                * non_ole task for running non-OLE specs (e.g. for browser setup &c.)
     * Compatibility Update
        * Updated compatibility file for most recent OLE Release - 0.8.0-u-r11754

    ### v0.1.0 - 2013/04/05

    * Initial commit
        * Created directory structure and base class files
    * Base class
        * Created base class with browser method as interface for Selenium Webdriver
    * Web Element class
        * Created web element class to extend functions of Selenium web element
        * Added Functions:
            * present? - tests if a web element is present, returns true or false
            * enabled? - tests if a web element is enabled, returns true or false
            * type() - enters given text into a web element
            * value - returns the value of an input element
    * Basic Structure
        * Elements
            * Element - base class for data objects and other non-page entities
            * Page - base class for pages in OLE
        * OLEFS
            * Element - used to define OLE Financial System data objects
            * Page - used to define OLE Financial System base page elements and functions
        * OLELS
            * Element - used to define OLE Library System data objects
            * Page - used to define OLE Library System base page elements and functions
        * Docstore
