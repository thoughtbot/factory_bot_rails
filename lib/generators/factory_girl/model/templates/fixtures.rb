# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :<%= singular_name %> do
<% for attribute in attributes -%>
    <%= attribute.name %> <%= attribute.default.inspect %>
<% end -%>
  end
end
