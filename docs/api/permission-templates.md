# Permission templates

[Permission template attributes](https://developers.lokalise.com/reference/permission-template-object)

## Fetch permission templates

[API doc](https://developers.lokalise.com/reference/list-all-permission-templates)

```ruby
permission_templates = test_client.permission_templates team_id

template = permission_templates[0]

template.id # => 1
template.role # => "Manager"
template.permissions # => ['branches_main_modify', ...]
template.description # => 'Manage project settings ...'
template.tag # => 'Full access'
template.tagColor # => 'green'
template.tagInfo # => ''
template.doesEnableAllReadOnlyLanguages # => true
```