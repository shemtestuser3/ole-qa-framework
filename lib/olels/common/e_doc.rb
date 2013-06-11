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

  # This class contains element definitions common to OLE Library System E-Docs.
  # Element definitions are stored in lib/olels/e_doc/elements.yml
  class E_Doc < OLE_QAF::Page

    def initialize(ole_browser, olels_url)
      super(ole_browser, olels_url)

      e_doc_elements = load_elements(subdir = '/olels/common/e_doc/')
      set_elements(e_doc_elements)
    end

  end


end