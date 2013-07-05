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

module OLE_QA::Framework::Page_Helpers
  # Login as a given user.
  # @param username [String] The username to use.
  # @return [Boolean] Whether the login process succeeded.
  def login(username)
    raise OLE_QA::Framework::Error,"Login field not present on this page: #{self.class.name}" unless @browser.text_field(:name => "backdoorId").present?
    @browser.text_field(:name => "backdoorId").set(username)
    @browser.input(:class => "go", :value => "Login").click
    @browser.div(:id => "login-info").strong(:text => /Impersonating User\:/, :text => /#{username}/).present?
  end

  # Logout from previous login.
  # @return [Boolean] Whether the logout process succeeded.
  def logout
    @browser.input(:class => "go", :value => "Logout").click
    # Return false if still impersonating user, true if not.
    @browser.div(:id => "login-info").strong(:text => /Impersonating User\:/).present? ? false : true
  end
end