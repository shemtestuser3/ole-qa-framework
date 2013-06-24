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

module OLE_QA::OLEFS
  # A new Accounting Line on an OLE Financial System PURAP Line Object
  class New_Accounting_Line < OLE_QA::Subline_Object
    # Initialize as a subclass of {OLE_QA::Subline_Object} with a subline_number of 0.
    def initialize(ole_session, line_number, which)
      super(ole_session, line_number, 0)
    end

    # Set elements on a New Accounting Line object.
    # @note {OLE_QA::Line_Object} @line_number and @line_id will be used to
    #   perform substitutions in identifiers.
    # @note {OLE_QA::Subline_Object} @line_number and @line_id will not be
    #   need in finding element IDs, as there will only ever be one new
    #   subline object on each line object.
    def set_elements
      super
      element(:chart_selector)                    {b.select_list(:id => "document.item[#{@line_id}].newSourceLine.chartOfAccountsCode")}
      element(:account_number_field)              {b.text_field(:id => "document.item[#{@line_id}].newSourceLine.accountNumber")}
      element(:sub_account_number_field)          {b.text_field(:id => "document.item[#{@line_id}].newSourceLine.subAccountNumber")}
      element(:object_field)                      {b.text_field(:id => "document.item[#{@line_id}].newSourceLine.financialObjectCode")}
      element(:sub_object_field)                  {b.text_field(:id => "document.item[#{@line_id}].newSourceLine.financialSubObjectCode")}
      element(:project_field)                     {b.text_field(:id => "document.item[#{@line_id}].newSourceLine.projectCode")}
      element(:org_ref_id_field)                  {b.text_field(:id => "document.item[#{@line_id}].newSourceLine.organizationReferenceId")}
      element(:dollar_field)                      {b.text_field(:id => "document.item[#{@line_id}].newSourceLine.amount")}
      element(:percent_field)                     {b.text_field(:id => "document.item[#{@line_id}].newSourceLine.accountLinePercent")}
      element(:add_button)                        {b.input(:name => "methodToCall.insertSourceLine.line#{@line_id}.anchoraccountingSourceAnchor")}
    end
  end
end