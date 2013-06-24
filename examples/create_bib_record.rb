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

require 'ole-qa-framework'

# Start a new instance of the OLE Testing Framework.
# Do not run the browser in headless mode.
ole = OLE_QA::Framework.new(:headless? => false)

# Create an instance of the OLELS Bib Editor Page.
bib_editor = OLE_QA::OLELS::Bib_Editor.new(ole)

# Open the page directly via URL.
# Automatically select the iframe with ID "iframeporlet"
# (the screen context in which most OLE functions are found).
bib_editor.open

# Enter a control line with tag "008" and a value of "HelloWorld"
bib_editor.control_008_link.click
bib_editor.control_008_field.wait_until_present
bib_editor.control_008_field.set("HelloWorld")

# Enter a Marc field & subfield line of
# "245 # # $aStardust"
bib_editor.data_line_1.tag_field.set("245")
bib_editor.data_line_1.data_field.set("|aStardust")

# Add another data line.
bib_editor.data_line_1.add_button.click
bib_editor.add_data_line(2)

# Enter a Marc field & subfield line
# "100 1 # $aNeil Gaiman"
bib_editor.data_line_2.tag_field.wait_until_present
bib_editor.data_line_2.tag_field.set("100")
bib_editor.data_line_2.ind1_field.set("1")
bib_editor.data_line_2.data_field.set("|aNeil Gaiman")

# Set the header fields before saving
bib_editor.set_button.click

# Save the record.
bib_editor.submit_button.click

# Print whatever message appears to the command line.
bib_editor.message.wait_until_present
puts bib_editor.message.text

# Return to the OLE Library System Main Menu via URL.
ole.browser.goto(ole.ls_url)

# Shut down the OLE Testing Framework.
ole.quit