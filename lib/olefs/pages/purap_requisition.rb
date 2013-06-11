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

module OLE_QAF::OLEFS
  # An OLE Financial System Requisition
  class Requisition < PURAP_Document

    include OLE_QAF::Page_Helpers

    def initialize(ole_browser, olefs_url)
      super(ole_browser, olefs_url)

      subdir = '/olefs/pages/purap_requisition/'

      req_elements = load_elements(subdir)
      set_elements(req_elements)

      @url = olefs_url + 'portal.do?channelTitle=Requisition&channelUrl=purapOleRequisition.do?methodToCall=docHandler&command=initiate&docTypeName=OLE_REQS'

    end
  end
end