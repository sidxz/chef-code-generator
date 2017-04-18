# chef-code-generator
A customized chef generator cookbook to include inspec tests. This is used by project inspec_handler (https://github.com/sidxz/inspec-handler/).  
More information about generator cookbooks can be found at  
https://blog.chef.io/2014/12/09/guest-post-creating-your-own-chef-cookbook-generator/  

# Usage
```bash
chef generate cookbook my_cookbook_name -g <path to generator cookbook>
```

Modify test_habdler run path in  chef-code-generator/templates/default/recipe.rb.erb to meet your organization's need.

To use the generator cookbook as default modify `~/.chef/config.rb` and add
``` ruby
chefdk.generator_cookbook = '/path/to/your/cookbook' if chefdk
```
