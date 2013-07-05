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

module OLE_QA::Framework::Helpers
  # Handle frame selection in the browser via aliasing the @browser session passed to a page or data object.
  # - If the page or data object is inherited by any kind of OLE e-Doc, all elements will be encapsulated within a frame
  #   with an ID of 'iframeportlet'.
  # - If the page is a main menu page or a lookup page, the frame may not be present.
  def browser
    if @ole.browser.frame(:id => 'iframeportlet').present?
      @ole.browser.frame(:id => 'iframeportlet')
    else
      @ole.browser
    end
  end
  alias_method(:b,:browser)

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

  # Unset a previously defined attribute on a class.
  def unmake_attr(method_name)
    eigenclass = class << self;
                   self
    end
    eigenclass.class_eval do
      undef_method(method_name)
    end
  end
  private :unmake_attr

  # Set an element definition on a page or data object.
  # - An element created with this method becomes an accessor attribute
  #   associated with an instance variable on the page or data object on
  #   which it is created.
  #
  # @param name [Symbol] The name the new element will have on the object.
  #   (This will be an instance variable, so it cannot contain spaces.)
  # @param force [Boolean] If set to true, this method can be used to override an existing element definition.
  #
  # @raise StandardError if a parameter is of an incorrect type.
  # @raise StandardError if an instance method already exists for an element with the same name.
  #   (Suppress with force = true.)
  #
  # @note This method can also be used to add an element to an existing page object instance.
  #   The code block passed to the method will need to explicitly name the class instance in order to
  #   access the browser method.
  #
  # @note In some cases in OLE, text_field elements are coded as <input> elements.  If Watir-Webdriver
  #   returns an error in a case like this, affixing .to_subtype should make the #set method available.
  #
  def set_element(name, force = false)
    raise StandardError, "Name must be a symbol.  Given: #{name} (#{name.class})" unless name.instance_of?(Symbol)
    eigenclass = class << self;
      self
    end
    raise StandardError, "Element is already defined.  (Use the 'force = true' option to suppress this error.)" if eigenclass.instance_methods.include?(name) && ! force
    eigenclass.class_eval do
      define_method name.to_s do
        yield self
      end
    end
    @elements << name
  end
  alias_method(:element, :set_element)

  # Set a function definition on a page or data object.
  # - A function created with this method becomes an accessor attribute
  #   associated with an instance variable on the page or data object on
  #   which it is created.
  #
  # @param name [Symbol] The name the new function will have on the object.
  #   (This will be an instance variable, so it cannot contain spaces.)
  # @param force [Boolean] If set to true, this method can be used to override an existing function definition.
  #
  # @raise StandardError if a parameter is of an incorrect type.
  # @raise StandardError if an instance method already exists for a function with the same name.
  #   (Suppress with force = true.)
  #
  # @note This method can also be used to add a function to an existing page object instance.
  #   The code block passed to the method will need to explicitly name the class instance in order to
  #   access the browser method.
  def set_function(name, force = false)
    raise StandardError, "Name must be a symbol.  Given: #{name} (#{name.class})" unless name.instance_of?(Symbol)
    eigenclass = class << self;
      self
    end
    raise StandardError, "Element is already defined.  (Use the 'force = true' option to suppress this error.)" if eigenclass.instance_methods.include?(name) && ! force
    eigenclass.class_eval do
      define_method name.to_s do
        yield self
      end
    end
    @functions << name
  end
  alias_method(:function,:set_function)

  # Load a YML file.
  def load_yml(subdir, filename)
    basedir = OLE_QA::Framework::load_dir
    file_path = basedir + '/' + subdir + filename
    if File.exists?(file_path) then
      yaml_file = File.open(file_path, 'r')
      yaml = YAML.load(yaml_file)
      yaml_file.close
      yaml
   else
      raise StandardError, "File does not exist. (#{basedir + subdir + filename})"
    end
  end
  alias_method(:load_yaml,:load_yml)
end