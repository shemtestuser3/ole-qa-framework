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

require 'ole_qa_framework'

# Start a new instance of the OLE Testing Framework.
# Do not run the browser in headless mode.
ole = OLE_QAF::Framework.new(:headless? => false)

# Create an instance of the OLELS Bib Editor Page.
bib_editor = OLE_QAF::OLELS::Bib_Editor.new(ole.browser, ole.ls_url)

# Open the page directly via URL.
# Automatically select the iframe with ID "iframeporlet"
# (the screen context in which most OLE functions are found).
bib_editor.open

# Enter "HelloWorld" in the Leader Field.
bib_editor.leader_line.value_field.type("HelloWorld")

# Enter a control line with tag "008" and a value of "HelloWorld"
bib_editor.control_line_1.tag_field.type("008")
bib_editor.control_line_1.value_field.type("HelloWorld")

# Enter a Marc field & subfield line of
# "245 # # $aStardust"
bib_editor.data_line_1.tag_field.type("245")
bib_editor.data_line_1.value_field.type("|aStardust")

# Add another data line.
bib_editor.add_data_line

# Enter a Marc field & subfield line
# "100 1 # $aNeil Gaiman"
bib_editor.data_line_2.tag_field.type("100")
bib_editor.data_line_2.indicator_1_field.type("1")
bib_editor.data_line_2.value_field.type("|aNeil Gaiman")

# Save the record.
bib_editor.save

# Return to the OLE Library System Main Menu via URL.
ole.browser.get(ole.ls_url)

# Shut down the OLE Testing Framework.
ole.quit