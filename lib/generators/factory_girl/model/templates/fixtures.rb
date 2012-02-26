# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :<%= singular_table_name %><%= explicit_class_option %> do
<% for attribute in attributes -%>
    <%= attribute.name %> <%= attribute.default.inspect %>
<% end -%>
  end
end
