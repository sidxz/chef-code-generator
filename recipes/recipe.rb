
context = ChefDK::Generator.context
cookbook_dir = File.join(context.cookbook_root, context.cookbook_name)
recipe_path = File.join(cookbook_dir, "recipes", "#{context.new_file_basename}.rb")
spec_helper_path = File.join(cookbook_dir, "spec", "spec_helper.rb")
spec_dir = File.join(cookbook_dir, "spec", "unit", "recipes")
spec_path = File.join(spec_dir, "#{context.new_file_basename}_spec.rb")
inspec_dir = File.join(cookbook_dir, "test", "smoke", "default")
inspec_path = File.join(inspec_dir, "#{context.new_file_basename}.rb")
inspec_server_test_dir = File.join(cookbook_dir, "templates", "default", "inspec-tests")
inspec_server_test_path = File.join(inspec_server_test_dir, "#{context.new_file_basename}_inspec.erb")

if File.directory?(File.join(cookbook_dir, "test", "recipes"))
  Chef::Log.deprecation <<-EOH
It appears that you have Inspec tests located at "test/recipes". This location can
cause issues with Foodcritic and has been deprecated in favor of "test/smoke/default".
Please move your existing Inspec tests to the newly created "test/smoke/default"
directory, and update the 'inspec_tests' value in your .kitchen.yml file(s) to
point to "test/smoke/default".
  EOH
end

# Chefspec
directory spec_dir do
  recursive true
end

cookbook_file spec_helper_path do
  action :create_if_missing
end

template spec_path do
  source "recipe_spec.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Inspec
directory inspec_dir do
  recursive true
end

template inspec_path do
  source 'inspec_default_test.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Recipe
template recipe_path do
  source "recipe.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
end

#@######################################################@#
# Customization 
# Author sid@tamu.edu
#@######################################################@#
#
# Server Side Inspec Tests
# Generate Dir if missing
directory inspec_server_test_dir do
  recursive true
end

# Generate File
template inspec_server_test_path do
  source "inspec_server_test.erb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end
