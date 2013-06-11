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

module OLE_QAF::OLELS

  # This represents the base object for the Describe Editor.
  # It generates elements common to all three editor screens:
  # - Bibliographic Editor
  # - Instance Editor (for Holdings)
  # - Item Editor
  class Editor < OLE_QAF::Page

    # The universal Describe Editor URL in OLELS.
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
    attr_accessor :url

    def initialize(browser, ole_ls_base_url)
      editor_url =  ole_ls_base_url + 'portal.do?channelTitle=Editor&channelUrl='
      editor_url += ole_ls_base_url + 'kr-krad/editorcontroller?viewId=EditorView&methodToCall=load&docCategory=work&docType=bibliographic&docFormat=marc&editable=true'
      super(browser, editor_url)
      @url = editor_url

      universal_editor_elements = load_elements('/olels/common/editor/')
      set_elements(universal_editor_elements)
    end

  end

end