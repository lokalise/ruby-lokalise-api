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
@client.team_user_groups team_id, limit: 1, page: 2
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
@client.create_team_user_group team_id, name: 'My group',
                                        is_reviewer: false,
                                        is_admin: false,
                                        languages: {
                                          reference: [123],
                                          contributable: [640]
                                        }
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

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.update(params)
```

For example:

```ruby
@client.update_team_user_group team_id, second_group_id,
                               name: 'Updated group',
                               is_admin: true,
                               is_reviewer: true
```

## Add projects to group

[Doc](https://developers.lokalise.com/reference/add-projects-to-group)

```ruby
@client.add_projects_to_group(team_id, group_id, project_ids) # Input:
                                                              ## team_id (string, required)
                                                              ## group_id (string, required)
                                                              ## project_ids (string or array, required) - project ids that you would like to add to this group
```

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.add_projects projects: [project_id1, project_id2]
```

## Remove projects from group

[Doc](https://developers.lokalise.com/reference/remove-projects-from-group)

```ruby
@client.remove_projects_from_group(team_id, group_id, project_ids)  # Input:
                                                                    ## team_id (string, required)
                                                                    ## group_id (string, required)
                                                                    ## project_ids (string or array, required) - project ids that you would like to remove from this group
```

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.remove_projects projects: [project_id1, project_id2]
```

## Add users to group

[Doc](https://developers.lokalise.com/reference/add-members-to-group)

```ruby
@client.add_users_to_group(team_id, group_id, user_ids) # Input:
                                                        ## team_id (string, required)
                                                        ## group_id (string, required)
                                                        ## user_ids (string or array, required) - user ids that you would like to add to this group
```

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.add_users users: [user_id1, user_id2]
```

## Remove users from group

[Doc](https://developers.lokalise.com/reference/remove-members-from-group)

```ruby
@client.remove_users_from_group(team_id, group_id, user_ids)  # Input:
                                                              ## team_id (string, required)
                                                              ## group_id (string, required)
                                                              ## user_ids (string or array, required) - user ids that you would like to add to this group
```

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.remove_users users: [user_id1, user_id2]
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

Alternatively:

```ruby
group = @client.team_user_group('team_id', 'group_id')
group.destroy
```
