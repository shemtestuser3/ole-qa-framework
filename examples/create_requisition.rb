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

require 'ole-qa-framework'

# Start a new instance of the OLE Testing Framework.
# Do not run the browser in headless mode.
ole = OLE_QA::Framework.new(:headless? => false)

# Create an instance of the OLEFS Requisition Page.
requisition = OLE_QA::OLEFS::Requisition.new(ole)

# Open the page directly via URL.
requisition.open

# Select a Delivery Location of Wells Library, Room 100
requisition.delivery_tab_toggle.click
requisition.building_search_icon.click
building_lookup = OLE_QA::OLEFS::Building_Lookup.new(ole)
building_lookup.building_name_field.set("Wells Library")
building_lookup.search_button.click
building_lookup.element(:return_building_link)  {building_lookup.browser.a(:xpath => "//td[contains(text(),'Wells Library')]/preceding-sibling::td[3]/a")}
building_lookup.return_building_link.click
requisition.room_field.set("100")

# Select a Vendor
requisition.vendor_tab_toggle.click
requisition.vendor_search_icon.wait_until_present
requisition.vendor_search_icon.click
vendor_lookup = OLE_QA::OLEFS::Vendor_Lookup.new(ole)
vendor_lookup.vendor_name_field.set("YBP")
vendor_lookup.search_button.click
vendor_lookup.element(:return_vendor_link)      {vendor_lookup.browser.a(:xpath => "//td[a[contains(text(),'YBP Library Services')]]/preceding-sibling::td[1]/a")}
vendor_lookup.return_vendor_link.click

# Enter a Bibliographic Record on the first Line Item
# - Use the minimum requisition requirement of a Title.
# - Use the Bib Editor minimum requirement of an 008 field and a leader field.
# - Print the success or failure message from the Bib Editor to the command line.
requisition.new_line_item.new_bib_button.click
ole.browser.windows[-1].use
bib_editor = OLE_QA::OLELS::Bib_Editor.new(ole)
bib_editor.wait_for_page_to_load
bib_editor.control_008_link.click
bib_editor.control_008_field.wait_until_present
bib_editor.control_008_field.set("HelloWorld")
bib_editor.data_line_1.tag_field.set("245")
bib_editor.data_line_1.data_field.set("|aWhere is Joe Merchant?")
bib_editor.set_button.click
bib_editor.submit_button.click
bib_editor.message.wait_until_present
puts bib_editor.message.text
bib_editor.close_button.click
ole.browser.windows[0].use

# Enter a list price for the Line Item
requisition.new_line_item.list_price_field.set("23.00")

# Add the Line Item
requisition.new_line_item.add_button.click
requisition.create_line_item(1)

# Apply the 100% of the Line Item's cost to Acct 2947494, Obj Code 7112
requisition.line_item_1.accounting_lines_toggle.click
requisition.line_item_1.new_accounting_line.chart_selector.select("BL")
requisition.line_item_1.new_accounting_line.account_number_field.set("2947494")
requisition.line_item_1.new_accounting_line.object_field.set("7112")
requisition.line_item_1.new_accounting_line.percent_field.set("100.00")
requisition.line_item_1.new_accounting_line.add_button.click

# Enter a Requestor Phone Number in Additional Institutional Info
requisition.additional_info_tab_toggle.click
requisition.additional_info_phone_number_field.wait_until_present
requisition.additional_info_phone_number_field.set("812-555-5555")

# Save the Requisition
requisition.save_button.click

# Submit the Requisition and print any resulting message to the command line.
requisition.submit_button.click
requisition.generic_message.wait_until_present
puts requisition.generic_message.text

# Exit
ole.quit