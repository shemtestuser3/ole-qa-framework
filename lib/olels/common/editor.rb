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

module OLE_QA::Framework::OLELS

  # This represents the base object for the Describe Editor.
  # It generates elements common to all three editor screens:
  # - Bibliographic Editor
  # - Instance Editor (for Holdings)
  # - Item Editor
  class Editor < OLE_QA::Framework::Page

    # The URL for this Page object is the universal Describe Editor URL in OLELS.
    # When the Editor is opened via URL, it will start on the
    # MARC Bibliographic Editor screen.
    #
    # NB:
    # The URL of the newly-opened editor instance
    # will differ from the URL with which the screen was
    # opened, so do not rely on URL equivalence tests
    # to verify whether or not the Editor has been opened
    # correctly.
    #
    def initialize(ole_session)
      editor_url =  ole_session.ls_url + 'portal.do?channelTitle=Editor&channelUrl='
      editor_url += ole_session.ls_url + 'ole-kr-krad/editorcontroller?viewId=EditorView&methodToCall=load&docCategory=work&docType=bibliographic&docFormat=marc&editable=true'
      super(ole_session, editor_url)
      set_lines if defined?(self.set_lines)
    end

    # Set elements common to all Editor screens.
    # @note "Return to Search" buttons will not appear when Editors are not invoked via Describe Workbench,
    #   despite their commonality.
    def set_elements
      element(:title)                           {b.h2(:class => "uif-headerText").span}
      element(:submit_button)                   {b.button(:id => "submitEditor")}
      element(:cancel_button)                   {b.button(:id => "cancelEditor")}
      element(:close_button)                    {b.button(:id => "closeEditor")}
      element(:return_to_search_button)         {b.button(:id => "returnToSearch_button")}
      element(:message)                         {b.span(:id => "workMessageSection_span")}
    end

    # Designate elements always expected to be present once the editor has finished loading.
    def wait_for_elements
      @wait_on << :title
    end

    # Create a Line Object on an Editor page.
    def create_line(instance_name, class_name, which=0)
      raise StandardError, "Line object already exists.  (#{instance_name})" if self.instance_variables.include?("@#{instance_name}".to_sym)
      new_line_name = instance_name
      make_accessor(:"#{instance_name}")
      klas = OLE_QA::Framework::OLELS.const_get(:"#{class_name}")
      instance_variable_set(:"@#{new_line_name}", klas.new(@ole, which))
    end

    # Remove a Line Object from an Editor page.
    def remove_line(instance_name)
      raise StandardError, "Line object does not exist.  (#{instance_name})" unless self.instance_variables.include?("@#{instance_name}".to_sym)
      remove_instance_variable("@#{instance_name}".to_sym)
      unmake_attr(instance_name.to_sym)
    end
  end
end