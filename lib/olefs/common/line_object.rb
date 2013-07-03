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

module OLE_QA::Framework::OLEFS
  # A line object with methods specific to OLEFS line objects.
  class Line_Object < OLE_QA::Framework::Line_Object
    def initialize(ole_session, line_number)
      super(ole_session, line_number)
      set_sublines if defined?(self.set_sublines)
    end

    def create_subline(instance_name, class_name, which=0)
      raise StandardError, "Subline object already exists. (#{instance_name})" if self.instance_variables.include?("@#{instance_name}".to_sym)
      new_line_name = instance_name
      make_accessor(:"#{new_line_name}")
      klas = OLE_QA::Framework::OLEFS.const_get(:"#{class_name}")
      instance_variable_set(:"@#{new_line_name}", klas.new(@ole, @line_number, which))
    end
    alias_method(:add_subline,:create_subline)

    def remove_subline(instance_name)
      raise StandardError, "Subline object does not exist. (#{instance_name})" unless self.instance_variables.include?("@#{instance_name}".to_sym)
      remove_instance_variable("@#{instance_name}".to_sym)
      unmake_attr(instance_name.to_sym)
    end
    alias_method(:delete_subline,:remove_subline)
  end
end