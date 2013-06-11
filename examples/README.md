# OLE QA Testing Framework
## Examples
- - -

### Create Bib Record
create_bib_record.rb

This example file shows the simplest way to create a minimal
MARC bibliographic record in the OLE Library System using this
Test Framework.  It creates the record directly in the editor,
saves the record, then closes out the session.  It does not
contain any asserts or rescues, so Selenium Errors and OLE
Errors are not handled.

For the sake of simplicity, random text is used to fulfill the
minimum criteria of a leader string and a control field string.

* Bib Record
    * Leader - 'HelloWorld'
    * Control Line - '008','HelloWorld'
    * Title - '245','','','$aStardust'
    * Author - '100','1','','$aNeil Gaiman'

### Create Requisition
create_requisition.rb

This example file shows the simplest straight-through path
to create a requisition with the minimum requirements for approval:
a vendor, a delivery address, a requestor phone number, and a line
item consisting of a bibliographic record with a title, a list price,
and an accounting string for the purchase to be applied to.

This script contains only one error-checking line:  at the end of the
script, there will be an if-elsif-else clause wherein the script first
checks for a success message upon submission of the requisition, and
prints it if found, and if not, checks for an error message, and prints
it if found.  If the script finds no success message and no error message,
it prints whatever message it finds in the appropriate div, with the
element name requisition.generic_message.

* Bib Record
    * Leader - 'HelloWorld'
    * Control Line - '008','HelloWorld'
    * Title - '245','Where is Joe Merchant?'
* Line Item
    * List Price - '23.00'
    * Accounting Chart Code - 'BL' (Bloomington)
    * Account Number - '2947494' (Linguistics)
    * Object Code - '7112' (Monographs)
    * Percentage - '100.00'
* Vendor
    * YBP Library Services
* Delivery
    * Building - 'Wells Library'
    * Room Number - '100'
* Requestor Info
    * Phone Number - '812-555-5555' (Bloomington, Non-Usable Number)