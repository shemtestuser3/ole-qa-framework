#  Copyright 2005-2013 The Kuali Foundation
#
#  Licensed under the Educational Community License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at:
#
#    http://www.opensource.org/licenses/ecl2.php
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

require "ole-qa-framework"

# Start a new instance of the OLE Testing Framework.
# Do not run the browser in headless mode.
ole = OLE_QA::Framework::Session.new(:headless? => false)

# Capture the start time in MM/DD/YYYY format.
time = Time.now.strftime("%m/%d/%y")

# Open a new requisition.
requisition = OLE_QA::Framework::OLEFS::Requisition.new(ole)
requisition.open

# Set the description field to "PURAP Workflow Test - MM/DD/YYYY".
requisition.description_field.set("PURAP Workflow Test - #{time}")

# Set the delivery address to Wells Library, Room 100.
requisition.delivery_tab_toggle.click
requisition.building_search_icon.click
building_lookup = OLE_QA::Framework::OLEFS::Building_Lookup.new(ole)
building_lookup.wait_for_page_to_load
building_lookup.building_name_field.set("Wells Library")
building_lookup.search_button.click
building_lookup.browser.a(:xpath => "//td[contains(text(),'Wells Library')]/preceding-sibling::td[3]/a").click
requisition.wait_for_page_to_load
requisition.room_field.set("100")
requisition.delivery_tab_toggle.click

# Select "YBP Library Services" as the vendor.
requisition.vendor_tab_toggle.click
requisition.vendor_search_icon.click
vendor_lookup = OLE_QA::Framework::OLEFS::Vendor_Lookup.new(ole)
vendor_lookup.wait_for_page_to_load
vendor_lookup.vendor_name_field.set("YBP")
vendor_lookup.search_button.click
vendor_lookup.browser.a(:xpath => "//td[a[contains(text(),'YBP Library Services')]]/preceding-sibling::td[1]/a").click
requisition.wait_for_page_to_load
requisition.vendor_tab_toggle.click

# Add a Bib Record to the new line item with a title only.
requisition.new_line_item.new_bib_button.click
ole.browser.windows[-1].use
bib_editor = OLE_QA::Framework::OLELS::Bib_Editor.new(ole)
bib_editor.wait_for_page_to_load
bib_editor.control_008_link.click
bib_editor.control_008_field.wait_until_present
bib_editor.control_008_field.set("HELLOWORLD")
bib_editor.data_line_1.tag_field.set("245")
bib_editor.data_line_1.data_field.set("|aTitle of Book")
bib_editor.set_button.click
bib_editor.submit_button.click
bib_editor.close_button.click
ole.browser.windows[0].use

# Set the list price to $235.00 and add the line item.
requisition.new_line_item.list_price_field.set("235.00")
requisition.new_line_item.add_button.click
requisition.add_line_item(1)
requisition.wait_for_page_to_load

# Open the line item's accounting lines subtab and add an accounting string.
# Chart      - Bloomington
# Account    - 2947494
# Object     - 7112
# Percentage - 100
requisition.line_item_1.accounting_lines_toggle.click
requisition.line_item_1.new_accounting_line.chart_selector.wait_until_present
requisition.line_item_1.new_accounting_line.chart_selector.select("BL")
requisition.line_item_1.new_accounting_line.account_number_field.set("2947494")
requisition.line_item_1.new_accounting_line.object_field.set("7112")
requisition.line_item_1.new_accounting_line.percent_field.set("100.00")
requisition.line_item_1.new_accounting_line.add_button.click
requisition.line_item_1.add_accounting_line(1)
requisition.line_item_1.accounting_line_1.chart_selector.wait_until_present

# Open the Additional Information tab and add a phone number.
requisition.additional_info_tab_toggle.click
requisition.additional_info_phone_number_field.set("812-555-5555")

# Submit the requisition and wait for a message to appear.
# Display that message on the command line.
requisition.submit_button.click
requisition.wait_for_page_to_load
requisition.generic_message.wait_until_present
puts "Requisition:".ljust(20) + "#{requisition.generic_message.text.strip}"

# Reload the requisition.
requisition.reload_button.click
requisition.wait_for_page_to_load

# Open the View Related tab and check for a purchase order link.
requisition.view_related_tab_toggle.click
requisition.view_related_po_link.wait_until_present



# Get the requisition's Document ID.  This will be needed to re-open the requisition later.
requisition_id = requisition.document_id.text.strip

# Get the text of the purchase order link in the View Related tab.
po_link_text = requisition.view_related_po_link.text.strip

# Use a basic spin assert to check whether the requisition has created an approved purchase order yet.
# Set the timeout to 30 seconds from now.
end_time = Time.now + 30
# Wait for a signal since until isn't wrapped in a method.
catch :done do
  # Repeat this loop until either the timeout expires or the loop is broken.
  until Time.now > end_time
    # Repeat this loop this on a one second interval.
    sleep 1
    # Reopen the requisition.
    ole.browser.goto("http://tst.ole.kuali.org/kew/DocHandler.do?command=displayDocSearchView&docId=#{requisition_id}")
    requisition.wait_for_page_to_load
    # Check the Purchase Order link text in the View Related tab.
    requisition.view_related_tab_toggle.click
    requisition.view_related_po_link.wait_until_present
    po_link_text = requisition.view_related_po_link.text.strip
    # Break out of this loop if the Purchase Order link has a non-asterisk text value.
    throw :done unless po_link_text == '********'
  end
end

# Open the purchase order.
ole.browser.goto(requisition.view_related_po_link.href)
purchase_order = OLE_QA::Framework::OLEFS::Purchase_Order.new(ole)
purchase_order.wait_for_page_to_load

# Get the purchase order number and the purchase order's total.
# These will be used to create the payment request.
po_number = purchase_order.document_type_id.text.strip
po_total = purchase_order.grand_total_field.text.strip

# Receive the purchase order.
purchase_order.receiving_button.click
receiving_doc = OLE_QA::Framework::OLEFS::Receiving_Document.new(ole)
receiving_doc.wait_for_page_to_load
receiving_doc.create_receiving_line(1)
receiving_doc.submit_button.click
receiving_doc.wait_for_page_to_load
# Wait for a message to appear after submitting the receiving document.
# Print that message to the command line.
receiving_doc.generic_message.wait_until_present
puts "Receiving:".ljust(20) + "#{receiving_doc.generic_message.text.strip}"

# Get a random string of 12 alphanumeric characters to use as the invoice number.
invoice_number = Array.new(12){rand(36).to_s(36)}.join

# Open the payment request creation screen, fill in invoice information,
# and create the payment request.
payment_request_create_screen = OLE_QA::Framework::OLEFS::PREQ_Creation.new(ole)
payment_request_create_screen.open
payment_request_create_screen.purchase_order_number_field.set(po_number)
payment_request_create_screen.invoice_date_field.set(time)
payment_request_create_screen.invoice_number_field.set(invoice_number)
payment_request_create_screen.invoice_amount_field.set(po_total)
payment_request_create_screen.continue_button.click

# Calculate and approve the payment request once it opens.
payment_request = OLE_QA::Framework::OLEFS::Payment_Request.new(ole)
payment_request.wait_for_page_to_load
payment_request.payment_method_selector.select("Check")
payment_request.calculate_button.click
payment_request.wait_for_page_to_load
payment_request.approve_button.click

# Print a final status message to the command line.
puts "Payment Request:".ljust(20)  + 'Approved.' unless payment_request.generic_message.present?

# Exit the OLE QA Testing Framework session.
ole.quit