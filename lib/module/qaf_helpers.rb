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

module OLE_QAF::Helpers

  # Add an accessor to a class from within that class only.
  def make_accessor(symbol)
    eigenclass = class << self;
                   self
    end
    eigenclass.class_eval do
      attr_accessor symbol
    end
  end
  private :make_accessor

  # Add a reader to a class from within that class only.
  def make_reader(symbol)
    eigenclass = class << self;
                   self
    end
    eigenclass.class_eval do
      attr_reader symbol
    end
  end
  private :make_reader

  # Add a writer to a class from within that class only.
  def make_writer(symbol)
    eigenclass = class << self;
                   self
    end
    eigenclass.class_eval do
      attr_writer symbol
    end
  end
  private :make_writer

  # Add constituents of an element hash to a Page or Data Object as instance variables.
  #
  # element_hash =
  #     { :element1 => [:e_doc, :xpath, "//x/path"],
  #       :element2 => [:selector, :id, "document.SelectorId"],
  #       :element3 => [:input, :id, "document.InputId"]
  #       :element4 => [:web, :name, "q"]
  #     }
  #
  def set_elements(element_hash)
    instance_hash = {}

    # Get element values and instantiate in instance hash.
    element_hash.keys.each do |key|
      which = element_hash[key][0]
      how = element_hash[key][1]
      what = element_hash[key][2]

      # Instantiate element classes based on element type (in which).
      case which
        when :data
          instance_hash[key] = OLE_QAF::Data_Element.new(@browser, how, what)
        when :input
          instance_hash[key] = OLE_QAF::Input_Element.new(@browser, how, what)
        when :selector
          instance_hash[key] = OLE_QAF::Selector_Element.new(@browser, how, what)
        when :checkbox
          instance_hash[key] = OLE_QAF::Checkbox_Element.new(@browser, how, what)
        when :web
          instance_hash[key] = OLE_QAF::Web_Element.new(@browser, how, what)
        when :array
          instance_hash[key] = OLE_QAF::Web_Element_Array.new(@browser, how, what)
        else
          raise StandardError, "Invalid element type #{which}.  Acceptable values are web, array, data, input, checkbox, and selector."
      end
    end

    # Set each instance as an accessor on the object.
    instance_hash.keys.each do |key|
      make_accessor(key)
      self.instance_variable_set("@#{key.to_s}", instance_hash[key])
    end

  end

  # Remove elements with the same hash they were instantiated from.
  def unset_elements(element_hash)
    element_hash.keys.each do |key|
      remove_instance_variable("@#{key.to_s}")
    end
  end

  # Load a YML file.
  def load_yml(subdir, filename)
    basedir = OLE_QAF::load_dir
    if File.exists?(basedir + subdir + filename) then
      yaml_file = File.open(basedir + subdir + filename, 'r')
      yaml = YAML.load(yaml_file)
      yaml_file.close
      yaml
   else
      raise StandardError, "File does not exist. (#{basedir + subdir + filename})"
    end
  end

  # Alias for .load_yml
  def load_yaml(subdir, filename)
    load_yml(subdir, filename)
  end

  # Load an elements definition file in YAML
  def load_elements( subdir, filename = 'elements.yml')
    load_yml(subdir, filename)
  end

end