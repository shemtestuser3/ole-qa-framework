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

require 'ole_qa_framework'

# Start a new instance of the OLE Testing Framework.
# Do not run the browser in headless mode.
ole = OLE_QAF::Framework.new(:headless? => false)

# Create an instance of the OLEFS Requisition Page.
requisition = OLE_QAF::OLEFS::Requisition.new(ole.browser, ole.base_url)

# Open the page directly via URL.
# Automatically select the frame with ID "iframeportlet"
# (the screen context in which most OLE functions are found).
requisition.open

# Select a Delivery Location of Wells Library, Room 100
requisition.delivery_tab_toggle.click
requisition.building_search_icon.click
building_lookup = OLE_QAF::OLEFS::Building_Lookup.new(ole.browser, ole.base_url)
building_lookup.building_name_field.type("Wells Library")
building_lookup.search_button.click
return_building_link = OLE_QAF::Data_Element.new(ole.browser, :xpath, "//td[contains(text(),'Wells Library')]/preceding-sibling::td[3]/a")
return_building_link.click
requisition.room_field.type("100")

# Select a Vendor
requisition.vendor_tab_toggle.click
requisition.vendor_search_icon.wait_til_enabled(5)
requisition.vendor_search_icon.click
vendor_lookup = OLE_QAF::OLEFS::Vendor_Lookup.new(ole.browser, ole.base_url)
vendor_lookup.vendor_name_field.type("YBP")
vendor_lookup.search_button.click
return_vendor_link = OLE_QAF::Data_Element.new(ole.browser, :xpath, "//td[a[contains(text(),'YBP Library Services')]]/preceding-sibling::td[1]/a")
return_vendor_link.click
requisition.vendor_name_added_field.wait_til_enabled(5)
requisition.vendor_name_added_field.verify_text("YBP Library Services")

# Enter a Bibliographic Record on the first Line Item
requisition.new_line_item.new_bib_button.click
ole.select_window(-1)
bib_editor = OLE_QAF::OLELS::Bib_Editor.new(ole.browser, ole.base_url)
bib_editor.frame_select
bib_editor.leader_line.value_field.type("HelloWorld")
bib_editor.control_line_1.tag_field.type("008")
bib_editor.control_line_1.value_field.type("HelloWorld")
bib_editor.data_line_1.tag_field.type("245")
bib_editor.data_line_1.value_field.type("|aWhere is Joe Merchant?")
bib_editor.save
bib_editor.close_button.click
ole.select_window(0)

# Enter a list price for the Line Item
requisition.frame_select
requisition.new_line_item.list_price_field.type("23.00")

# Add the Line Item
requisition.new_line_item.add_button.click
requisition.create_line_item

# Apply the 100% of the Line Item's cost to Acct 2947494, Obj Code 7112
requisition.line_item_1.accounting_lines_toggle.click
requisition.line_item_1.new_accounting_line.chart_selector.select_option(:text, "BL")
requisition.line_item_1.new_accounting_line.account_number_field.type("2947494")
requisition.line_item_1.new_accounting_line.object_field.type("7112")
requisition.line_item_1.new_accounting_line.percent_field.type("100.00")
requisition.line_item_1.new_accounting_line.add_button.click

# Enter a Requestor Phone Number in Additional Institutional Info
requisition.additional_info_tab_toggle.click
requisition.phone_number_field.type("812-555-5555")

# Save the Requisition
requisition.save_button.click

# Submit the Requisition and print the confirmation message to the command
# line.  If the confirmation message is not present, print the error message
# instead, or any other message found in the top "left-errmsg" div.
requisition.submit_button.click
if requisition.submit_message.present? then
  puts requisition.submit_message.text
elsif requisition.error_message.present? then
  puts requisition.error_message.text
else
  puts requisition.generic_message.text
end

# Exit
ole.quit