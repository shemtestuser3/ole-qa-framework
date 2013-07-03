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
  # An Accounting Line in an OLE Financial System PURAP E-Document.
  class Accounting_Line < OLE_QA::Framework::Subline_Object
    # Set accounting line elements.
    def set_elements
      super
      # Fields
      element(:account_number_field)          {b.text_field(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].accountNumber")}
      element(:sub_account_number_field)      {b.text_field(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].subAccountNumber")}
      element(:object_field)                  {b.text_field(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].financialObjectCode")}
      element(:sub_object_field)              {b.text_field(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].financialSubObjectCode")}
      element(:project_field)                 {b.text_field(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].projectCode")}
      element(:org_ref_id_field)              {b.text_field(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].organizationReferenceId")}
      element(:dollar_field)                  {b.text_field(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].amount")}
      element(:percent_field)                 {b.text_field(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].accountLinePercent")}
      # Selectors
      element(:chart_selector)                {b.select_list(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].chartOfAccountsCode")}
      # Inputs, Radio Buttons, & Checkboxes
      element(:delete_button)                 {b.input(:name => "methodToCall.deleteSourceLine.line#{@line_id}.#{@subline_id}.anchoraccountingSourceAnchor")}
      element(:balance_inquiry_button)        {b.input(:name => "methodToCall.performBalance(InquiryForSourceLine.line#{@line_id}:#{@subline_id}.anchoraccountingSourceExistingLineLineAnchor#{@subline_id}")}
      # Readonly Fields
      # Use the fields below when the target accounting line was added on an earlier PURAP document
      # (e.g., for accounting lines on a purchase order which were added on the requisition).
      element(:closed_chart_field)            {b.div(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].chart.finChartOfAccountDescription.div").parent.a}
      element(:closed_account_number_field)   {b.div(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].account.accountName.div").parent.a}
      element(:closed_object_field)           {b.div(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].objectCode.financialObjectCodeName.div").parent.a}
      element(:closed_dollar_field)           {b.div(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].amount.div")}
      element(:closed_percent_field)          {b.div(:id => "document.item[#{@line_id}].sourceAccountingLine[#{@subline_id}].sourceAccountingLinePercent.div")}
    end
  end

end