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

require 'rspec'
require 'spec_helper'

describe 'The OLEFS PURAP workflow' do

  before :all do
    @ole = OLE_QA::Framework::Session.new
    @requisition = OLE_QA::Framework::OLEFS::Requisition.new(@ole)
    @purchase_order = OLE_QA::Framework::OLEFS::Purchase_Order.new(@ole)
    @receiving_doc = OLE_QA::Framework::OLEFS::Receiving_Document.new(@ole)
    @payment_request = OLE_QA::Framework::OLEFS::Payment_Request.new(@ole)
  end

  after :all do
    @ole.quit
  end

  context "requisition" do

    it 'should open a requisition' do
      @requisition.open
      @requisition.title.text.strip.should == "Requisition"
    end

    it 'should set the description field to PURAP Workflow Test' do
      @requisition.description_field.set("PURAP Workflow Test")
      @requisition.description_field.value.should == "PURAP Workflow Test"
      @requisition.description_field.set("PURAP Workflow Test - #{Time.now}")
    end

    it 'should set the building to Wells Library, room 100' do
      @requisition.delivery_tab_toggle.click
      @requisition.building_search_icon.click
      building_lookup = OLE_QA::Framework::OLEFS::Building_Lookup.new(@ole)
      building_lookup.wait_for_page_to_load
      building_lookup.building_name_field.set("Wells Library")
      building_lookup.search_button.click
      building_lookup.browser.a(:xpath => "//td[contains(text(),'Wells Library')]/preceding-sibling::td[3]/a").click
      @requisition.room_field.set("100")
      @requisition.building_field.text.strip.should == "Wells Library"
      @requisition.room_field.value.strip.should == "100"
      @requisition.delivery_tab_toggle.click
    end

    it 'should set the vendor to YBP' do
      @requisition.vendor_tab_toggle.click
      @requisition.vendor_search_icon.click
      vendor_lookup = OLE_QA::Framework::OLEFS::Vendor_Lookup.new(@ole)
      vendor_lookup.wait_for_page_to_load
      vendor_lookup.vendor_name_field.set("YBP")
      vendor_lookup.search_button.click
      vendor_lookup.browser.a(:xpath => "//td[a[contains(text(),'YBP Library Services')]]/preceding-sibling::td[1]/a").click
      @requisition.closed_vendor_name_field.text.strip.should == "YBP Library Services"
    end

    it 'should create a Bib Record' do
      @requisition.new_line_item.new_bib_button.click
      @ole.browser.windows[-1].use
      bib_editor = OLE_QA::Framework::OLELS::Bib_Editor.new(@ole)
      bib_editor.wait_for_page_to_load
      bib_editor.control_008_link.click
      bib_editor.control_008_field.present?.should be_true
      bib_editor.control_008_field.set("HELLOWORLD")
      bib_editor.control_008_field.value.should == "HELLOWORLD"
      bib_editor.data_line_1.tag_field.set("245")
      bib_editor.data_line_1.data_field.set("|aTitle of Book")
      bib_editor.data_line_1.tag_field.value.should == "245"
      bib_editor.data_line_1.data_field.value.should == "|aTitle of Book"
      bib_editor.set_button.click
      bib_editor.leader_field.value.should_not be_empty
      bib_editor.submit_button.click
      bib_editor.message.text.include?("successfully created").should be_true
      bib_editor.close_button.click
      @ole.browser.windows[0].use
    end

    it 'should add the line item' do
      @requisition.new_line_item.list_price_field.set("235")
      @requisition.new_line_item.add_button.click
      @requisition.add_line_item(1)
      @requisition.line_item_1.list_price_field.value.should == "235.00"
      @requisition.line_item_1.description_field.text.strip.should == "Title of Book"
    end

    it 'should add an accounting line' do
      @requisition.line_item_1.accounting_lines_toggle.click
      @requisition.line_item_1.new_accounting_line.chart_selector.wait_until_present
      @requisition.line_item_1.new_accounting_line.chart_selector.select("BL")
      @requisition.line_item_1.new_accounting_line.account_number_field.set("2947494")
      @requisition.line_item_1.new_accounting_line.object_field.set("7112")
      @requisition.line_item_1.new_accounting_line.percent_field.set("100.00")
      @requisition.line_item_1.new_accounting_line.add_button.click
      @requisition.line_item_1.add_accounting_line(1)
      @requisition.line_item_1.accounting_line_1.chart_selector.wait_until_present
      @requisition.line_item_1.accounting_line_1.chart_selector.value.should == "BL"
      @requisition.line_item_1.accounting_line_1.account_number_field.value.should == "2947494"
      @requisition.line_item_1.accounting_line_1.object_field.value.should == "7112"
      @requisition.line_item_1.accounting_line_1.percent_field.value.should == "100.00"
    end

    it 'should set the additional info phone number' do
      @requisition.additional_info_tab_toggle.click
      @requisition.additional_info_phone_number_field.set("812-555-5555")
      @requisition.additional_info_phone_number_field.value.should == "812-555-5555"
      @requisition.additional_info_tab_toggle.click
    end

    it 'should submit the requisition' do
      @requisition.submit_button.click
      @requisition.wait_for_page_to_load
      @requisition.generic_message.wait_until_present
      @requisition.submit_message.present?.should be_true
    end

    it 'should go to final status' do
      sleep 15
      @requisition.reload_button.click
      @requisition.wait_for_page_to_load
      outcome = @requisition.document_status.text.strip
      outcome.should == "FINAL"
    end

    it 'should have a related PO' do
      @requisition.view_related_tab_toggle.click
      @requisition.view_related_po_link.wait_until_present
      @requisition.view_related_po_link.href.should_not be_empty
    end

    after :all do
      @ole.browser.goto(@requisition.view_related_po_link.href)
    end
  end

  context "purchase order" do

    it 'should create a new purchase order' do
      @purchase_order = OLE_QA::Framework::OLEFS::Purchase_Order.new(@ole)
    end

    it 'should wait for the purchase order to load' do
      @purchase_order.wait_for_page_to_load
    end

    it 'should be a purchase order' do
      @purchase_order.title.text.strip.should == "Purchase Order"
    end
  end

  context "receive and pay" do
    before :all do
      @po_number = @purchase_order.document_type_id.text.strip
      @po_total = @purchase_order.grand_total_field.text.strip
    end

    it 'should receive the purchase order' do
      @purchase_order.receiving_button.click
      @receiving_doc.wait_for_page_to_load
    end

    it 'should fill in the receiving document' do
      @receiving_doc.create_receiving_line(1)
      @receiving_doc.receiving_line_1.item_received_quantity_field.value.should == "1"
      @receiving_doc.receiving_line_1.item_received_parts_field.value.should == "1"
    end

    it 'should submit the receiving document' do
      @receiving_doc.submit_button.click
      @receiving_doc.wait_for_page_to_load
      @receiving_doc.submit_message.present?.should be_true
    end

    it 'should create a payment request' do
      preq_creation_screen = OLE_QA::Framework::OLEFS::PREQ_Creation.new(@ole)
      preq_creation_screen.open
      preq_creation_screen.purchase_order_number_field.set(@po_number)
      preq_creation_screen.purchase_order_number_field.value.strip.should == @po_number
      foo = Time.now.strftime("%m/%d/%y")
      preq_creation_screen.invoice_date_field.set(foo)
      preq_creation_screen.invoice_date_field.value.strip.should == foo
      bar = Array.new(12){rand(36).to_s(36)}.join
      preq_creation_screen.invoice_number_field.set(bar)
      preq_creation_screen.invoice_number_field.value.strip.should == bar
      preq_creation_screen.invoice_amount_field.set(@po_total)
      preq_creation_screen.invoice_amount_field.value.strip.should == @po_total
      preq_creation_screen.continue_button.click
    end

    it 'should open the payment request' do
      @payment_request.wait_for_page_to_load
      @payment_request.title.text.strip.should == "Payment Request"
    end

    it 'should set the payment method to be used' do
      @payment_request.payment_method_selector.select("Check")
      @payment_request.payment_method_selector.selected?("Check").should be_true
    end

    it 'should calculate the payment request' do
      @payment_request.calculate_button.click
    end

    it 'should blanket approve the payment request' do
      @payment_request.approve_button.click
      @ole.browser.title.should == "Kuali Portal Index"
    end
  end
end