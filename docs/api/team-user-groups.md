# Team user groups

## Fetch team user groups

[Doc](https://developers.lokalise.com/reference/list-all-groups)

```ruby
@client.team_user_groups(team_id, params = {})  # Input:
                                                ## team_id (string, required)
                                                ## params (hash)
                                                ### :page and :limit
                                                # Output:
                                                ## Collection of team user groups
```

For example:

```ruby
team_id = '1234'
params = {
  limit: 1,
  page: 2
}

groups = @client.team_user_groups team_id, params

groups[0].group_id # => '5678'
```

## Fetch a single group

[Doc](https://developers.lokalise.com/reference/retrieve-a-group)

```ruby
@client.team_user_group(team_id, group_id)  # Input:
                                            ## team_id (string, required)
                                            ## group_id (string, required)
                                            # Output:
                                            ## Group
```

For example:

```ruby
team_id = '1234'
group_id = '5678'

group = test_client.team_user_group team_id, group_id

group.name # => 'Demo'
```

## Create group

[Doc](https://developers.lokalise.com/reference/create-a-group)

```ruby
@client.create_team_user_group(team_id, params) # Input:
                                                ## team_id (string, required)
                                                ## params (hash, required):
                                                ### :name (string, required)
                                                ### :is_reviewer (boolean, required)
                                                ### :is_admin (boolean, required)
                                                ### :admin_rights (array) - required only if is_admin is true
                                                ### :languages (array of hashes) - required if is_admin is false
                                                # Output:
                                                ## Updated group
```

For example:

```ruby
params = {
  name: 'SDK',
  is_reviewer: true,
  is_admin: false,
  languages: {
    reference: [],
    contributable: [640]
  }
}

group = @client.create_team_user_group team_id, params

group.name # => 'SDK'
group.permissions['is_admin'] # => false
```

## Update group

[Doc](https://developers.lokalise.com/reference/update-a-group)

```ruby
@client.update_team_user_group(team_id, group_id, params) # Input:
                                                          ## team_id (string, required)
                                                          ## group_id (string, required)
                                                          ## params (hash, required):
                                                          ### :name (string, required)
                                                          ### :is_reviewer (boolean, required)
                                                          ### :is_admin (boolean, required)
                                                          ### :admin_rights (array) - required only if is_admin is true
                                                          ### :languages (array of hashes) - required if is_admin is false
                                                          # Output:
                                                          ## Updated group
```

For example:

```ruby
params = {
  name: 'Updated SDK',
  is_reviewer: true,
  is_admin: false,
  languages: {
    reference: [],
    contributable: [640]
  }
}

group = @client.update_team_user_group team_id, group_id, params

group.name # => 'Updated SDK'
```

Alternatively:

```ruby
group = @client.team_user_group team_id, group_id
updated_group = group.update params
```

## Add projects to group

[Doc](https://developers.lokalise.com/reference/add-projects-to-group)

```ruby
@client.add_projects_to_group(team_id, group_id, project_ids) # Input:
                                                              ## team_id (string, required)
                                                              ## group_id (string, required)
                                                              ## project_ids (string or array, required) - project ids that you would like to add to this group
```

For example:

```ruby
project_ids = %w[123.abc 567.def]

group = client.add_projects_to_group team_id, group_id, project_ids

group.projects # => ['123.abc', '567.def']
```

Alternatively:

```ruby
group = @client.team_user_group team_id, group_id
updated_group = group.add_projects project_ids
```

## Remove projects from group

[Doc](https://developers.lokalise.com/reference/remove-projects-from-group)

```ruby
@client.remove_projects_from_group(team_id, group_id, project_ids)  # Input:
                                                                    ## team_id (string, required)
                                                                    ## group_id (string, required)
                                                                    ## project_ids (string or array, required) - project ids that you would like to remove from this group
```

For example:

```ruby
project_ids = %w[123.abc 567.def]

group = @client.remove_projects_from_group team_id, group_id, project_ids

group.projects # => []
```

Alternatively:

```ruby
group = @client.team_user_group team_id, group_id
updated_group = group.remove_projects project_ids
```

## Add users to group

[Doc](https://developers.lokalise.com/reference/add-members-to-group)

```ruby
@client.add_users_to_group(team_id, group_id, user_ids) # Input:
                                                        ## team_id (string, required)
                                                        ## group_id (string, required)
                                                        ## user_ids (string or array, required) - user ids that you would like to add to this group
```

For example:

```ruby
user_ids = %w[1234 6789]
group = @client.add_members_to_group team_id, group_id, user_ids

group.members # => ['1234', '6789']
```

Alternatively:

```ruby
group = @client.team_user_group team_id, group_id

updated_group = group.add_users user_ids
```

## Remove users from group

[Doc](https://developers.lokalise.com/reference/remove-members-from-group)

```ruby
@client.remove_users_from_group(team_id, group_id, user_ids)  # Input:
                                                              ## team_id (string, required)
                                                              ## group_id (string, required)
                                                              ## user_ids (string or array, required) - user ids that you would like to add to this group
```

For example:

```ruby
user_ids = %w[1234 6789]

group = @client.remove_members_from_group team_id, group_id, user_ids

group.members # => []
```

Alternatively:

```ruby
group = @client.team_user_group team_id, group_id
updated_group = group.remove_users user_ids
```

## Destroy group

[Doc](https://developers.lokalise.com/reference/delete-a-group)

```ruby
@client.destroy_team_user_group(team_id, group_id)  # Input:
                                                    ## team_id (string, required)
                                                    ## group_id (string, required)
                                                    # Output:
                                                    ## Hash with "team_id" and "group_deleted" set to "true"
```

For example:

```ruby
response = @client.destroy_team_user_group team_id, group_id

response.group_deleted # => true
```

Alternatively:

```ruby
group = @client.team_user_group team_id, group_id
response = group.destroy
```