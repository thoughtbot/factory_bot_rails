# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :<%= file_path %><%= ", :class => #{class_path}" if namespaced? %> do
<% for attribute in attributes -%>
    <%= attribute.name %> <%= attribute.default.inspect %>
<% end -%>
  end
end
