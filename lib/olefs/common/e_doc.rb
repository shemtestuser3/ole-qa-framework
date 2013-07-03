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

module OLE_QA::Framework::OLEFS

  # This class contains element definitions common to OLE Financial System E-Docs.
  # Element definitions are stored in lib/olefs/e_doc/elements.yml
  class E_Doc < OLE_QA::Framework::Page
    # Automatically set element definitions on the E-Document object.
    # @note This method is automagically invoked on any Page object.  (see {OLE_QA::Framework::OLEFS::Page#initialize})
    def set_elements
      super
      # General Info
      element(:title)                         {b.div(:id => 'headerarea').h1}
      # Header Area
      element(:document_id)                   {b.th(:text => /Doc Nbr\:/).parent.td(:index => 0)}
      element(:document_status)               {b.th(:text => /Status\:/).parent.td(:index => 1)}
      element(:document_type_id)              {b.table(:class => 'headerinfo').tbody.tr(:index => 2).td(:index => 0)}
      element(:document_type_status)          {b.table(:class => 'headerinfo').tbody.tr(:index => 2).td(:index => 1)}
      element(:document_create_date)          {b.table(:class => 'headerinfo').tbody.tr(:index => 1).td(:index => 1)}
      # Document Overview
      element(:document_overview_tab_toggle)  {b.input(:id => 'tab-DocumentOverview-imageToggle')}
      element(:description_field)             {b.text_field(:id => 'document.documentHeader.documentDescription')}
      element(:explanation_field)             {b.text_field(:id => 'document.documentHeader.explanation')}
      # Global Input Buttons
      element(:approve_button)                {b.div(:id => 'globalbuttons').input(:title => 'blanket approve')}
      element(:save_button)                   {b.div(:id => 'globalbuttons').input(:title => 'save')}
      element(:submit_button)                 {b.div(:id => 'globalbuttons').input(:title => 'submit')}
      element(:calculate_button)              {b.div(:id => 'globalbuttons').input(:title => 'Calculate')}
      element(:close_button)                  {b.div(:id => 'globalbuttons').input(:title => 'close')}
      element(:cancel_button)                 {b.div(:id => 'globalbuttons').input(:title => 'cancel')}
      element(:copy_button)                   {b.div(:id => 'globalbuttons').input(:title => 'Copy current document')}
      element(:send_ad_hoc_button)            {b.div(:id => 'globalbuttons').input(:title => 'Send AdHoc Requests')}
      element(:reload_button)                 {b.div(:id => 'globalbuttons').input(:title => 'reload')}
      # Confirmation Screen Buttons
      element(:close_yes_button)              {b.div(:id => 'globalbuttons').input(:name => 'methodToCall.processAnswer.button0')}
      element(:close_no_button)               {b.div(:id => 'globalbuttons').input(:name => 'methodToCall.processAnswer.button1')}
      element(:cancel_yes_button)             {b.div(:id => 'globalbuttons').input(:name => 'methodToCall.processAnswer.button0')}
      element(:cancel_no_button)              {b.div(:id => 'globalbuttons').input(:name => 'methodToCall.processAnswer.button1')}
      # Messages
      element(:save_message)                  {b.div(:class => 'left-errmsg').div(:text => /Document was successfully saved\./)}
      element(:submit_message)                {b.div(:class => 'left-errmsg').div(:text => /Document was successfully submitted\./)}
      element(:error_message)                 {b.div(:class => 'left-errmsg').div(:class => 'error', :text => /error/, :text => /found on page/)}
      element(:generic_message)               {b.div(:class => 'left-errmsg').div}
      # Multiple Error Message Components     Watir::HTMLElementCollection
      element(:errors_in_tab)                 {b.strongs(:text => /Errors found in this Section\:/)}
    end

    # Wait for the following elements to be loaded when opening an E-Document page.
    def wait_for_elements
      @wait_on << :title
      @wait_on << :document_id
      super
    end

    # Returns an array of both "Errors in this Section" messages and individual error messages from each section.
    def get_error_array
      error_array = Array.new
      self.errors_in_tab.each do |error_in_tab|
        error_array << error_in_tab
        error_in_tab.parent.divs.each do |error|
         error_array << error
        end
      end
      error_array
    end
  end
end