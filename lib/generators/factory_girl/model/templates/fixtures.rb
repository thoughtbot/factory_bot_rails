# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :<%= singular_name %> do |f|
<% for attribute in attributes -%>
  f.<%= attribute.name %> <%= attribute.default.inspect %>
<% end -%>
end