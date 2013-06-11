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
  # The Building Lookup Screen in OLEFS
  class Building_Lookup < Lookup

    def initialize(browser, ole_base_url)
      # Set @url instance variable from OLE Base URL variable
      url = ole_base_url + \
        'portal.do?channelTitle=Building&channelUrl=kr/lookup.do?methodToCall=start&businessObjectClassName=org.kuali.ole.sys.businessobject.Building&docFormKey=88888888&returnLocation='\
        + ole_base_url + \
        'portal.do&hideReturnLink=true'
      super(browser, url)

      subdir = '/olefs/pages/building_lookup/'
      elements = load_elements(subdir)
      set_elements(elements)
    end

  end
end