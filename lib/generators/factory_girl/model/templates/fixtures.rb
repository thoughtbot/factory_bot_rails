# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :<%= singular_name %><%= ", :class = > #{class_name}" if class_path.present? %> do
<% for attribute in attributes -%>
    <%= attribute.name %> <%= attribute.default.inspect %>
<% end -%>
  end
end
