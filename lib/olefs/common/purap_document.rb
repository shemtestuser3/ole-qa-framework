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
  # An OLE Financial System PURchasing/Accounts Payable Document
  class PURAP_Document < E_Doc
    def initialize(ole_session, url)
      super(ole_session, url)
      set_lines if defined?(self.set_lines)
    end

    # Set PURAP Document Elements.
    def set_elements
      super
      # View Related Documents Tab
      element(:view_related_tab_toggle)                           {b.input(:id => "tab-ViewRelatedDocuments-imageToggle")}
      element(:view_related_po_link)                              {b.a(:xpath => "//div[@id='tab-ViewRelatedDocuments-div']/descendant::h3[contains(text(),'Purchase Order')]/a")}
      element(:view_related_requisition_link)                     {b.a(:xpath => "//div[@id='tab-ViewRelatedDocuments-div']/descendant::h3[contains(text(),'Requisition')]/a")}
      # Delivery Tab
      element(:delivery_tab_toggle)                               {b.input(:id => "tab-Delivery-imageToggle")}
      element(:building_field)                                    {b.td(:xpath => "//div[@id='tab-Delivery-div']/div/table/tbody/tr[2]/td[1]")}
      element(:campus_field)                                      {b.td(:xpath => "//div[@id='tab-Delivery-div']/div/table/tbody/tr[1]/td[1]")}
      element(:closed_room_field)                                 {b.td(:xpath => "//div[@id='tab-Delivery-div']/div/table/tbody/tr[5]/td[1]")}
      element(:closed_building_field)                             {b.td(:xpath => "//div[@id='tab-Delivery-div']/div/table/tbody/tr[2]/td[1]")}
      element(:closed_campus_field)                               {b.td(:xpath => "//div[@id='tab-Delivery-div']/div/table/tbody/tr[1]/td[1]")}
      element(:closed_address_1_field)                            {b.td(:xpath => "//div[@id='tab-Delivery-div']/descendant::tr[3]/th[1]/following-sibling::td[1]")}
      element(:closed_address_2_field)                            {b.td(:xpath => "//div[@id='tab-Delivery-div']/descendant::tr[4]/th[1]/following-sibling::td[1]")}
      element(:closed_city_field)                                 {b.td(:xpath => "//div[@id='tab-Delivery-div']/descendant::tr[6]/th[1]/following-sibling::td[1]")}
      element(:closed_state_field)                                {b.td(:xpath => "//div[@id='tab-Delivery-div']/descendant::tr[7]/th[1]/following-sibling::td[1]")}
      element(:closed_postal_code_field)                          {b.td(:xpath => "//div[@id='tab-Delivery-div']/descendant::tr[8]/th[1]/following-sibling::td[1]")}
      element(:closed_country_field)                              {b.td(:xpath => "//div[@id='tab-Delivery-div']/descendant::tr[9]/th[1]/following-sibling::td[1]")}
      element(:closed_delivery_to_field)                          {b.td(:xpath => "//div[@id='tab-Delivery-div']/descendant::tr[1]/th[1]/following-sibling::td[2]")}
      element(:closed_delivery_phone_number_field)                {b.td(:xpath => "//div[@id='tab-Delivery-div']/descendant::tr[2]/th[1]/following-sibling::td[2]")}
      element(:closed_email_field)                                {b.td(:xpath => "//div[@id='tab-Delivery-div']/descendant::tr[3]/th[1]/following-sibling::td[2]")}
      # Vendor Tab
      element(:vendor_tab_toggle)                                 {b.input(:id => "tab-Vendor-imageToggle")}
      element(:closed_vendor_name_field)                          {b.td(:xpath => "//tr/th[div[contains(text(),'Suggested Vendor:')]]/following-sibling::td[1]")}
      # Route Log Tab
      element(:route_log_tab_toggle)              {b.input(:id => "tab-RouteLog-imageToggle")}
      # element(:actions_taken)                     {b.bs(:xpath => "//div[@id='tab-ActionsTaken-div']/div[1]/table/tbody/tr/td[1]/b")}
      # element(:actions_taken_by)                  {b.as(:xpath => "//div[@id='tab-ActionsTaken-div']/div[1]/table/tbody/tr/td[2]/a")}
    end

    # Create a Line Object on a PURAP Document page.
    def create_line(instance_name, class_name, which=0)
      raise StandardError, "Line object already exists.  (#{instance_name})" if self.instance_variables.include?("@#{instance_name}".to_sym)
      new_line_name = instance_name
      make_accessor(:"#{instance_name}")
      klas = OLE_QA::OLEFS.const_get(:"#{class_name}")
      instance_variable_set(:"@#{new_line_name}", klas.new(@ole, which))
    end
    alias_method(:add_line,:create_line)

    # Remove a Line Object from a PURAP Document page.
    def remove_line(instance_name)
      raise StandardError, "Line object does not exist.  (#{instance_name})" unless self.instance_variables.include?("@#{instance_name}".to_sym)
      remove_instance_variable("@#{instance_name}".to_sym)
      unmake_attr(instance_name.to_sym)
    end
    alias_method(:delete_line,:remove_line)
  end
end