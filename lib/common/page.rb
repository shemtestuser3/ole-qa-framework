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

module OLE_QAF

  # An OLE Page object
  class Page

    attr_accessor :browser, :url

    include OLE_QAF::Helpers
    include OLE_QAF::Page_Helpers

    def initialize(browser, url)
      @browser = browser
      @url = url
    end

    # Check if a frame with the given ID is present.
    # Defaults to "iframeportlet".
    def frame_present?(frame_id = "iframeportlet")
      frame_element = Web_Element.new(@browser, :id, frame_id)
      frame_element.present?
    rescue
      Selenium::WebDriver::Error::NoSuchElementError
      false
    end

    # Select a frame with the given ID if it is present.
    # Defaults to "iframeportlet".
    def frame_select(frame_id = "iframeportlet")
      if frame_present?(frame_id) then
        @browser.switch_to.frame(frame_id)
      else
        raise StandardError, "Frame with id #{frame_id} not found."
      end
    end

    # Open the page via URL.
    # In subclasses, this method may include a call to frame_select.
    def open
      @browser.get(@url)
    end

  end

end