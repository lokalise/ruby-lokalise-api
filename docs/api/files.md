# Translation files

## Fetch translation files

[Doc](https://developers.lokalise.com/reference/list-all-files)

```ruby
@client.files(project_id, params = {})  # Input:
                                        ## project_id (string, required)
                                        ## params (hash)
                                        ### :page and :limit
                                        # Output:
                                        ## Collection of translation files available in the given project
```

For example:

```ruby
project_id = '123.abc'

files = @client.files project_id, limit: 3, page: 2

files[0].filename # => 'demo.json'
```

Alternatively:

```ruby
project = @client.project project_id

files = project.files limit: 3, page: 2
```

## Download translation files

[Doc](https://developers.lokalise.com/reference/download-files)

Exports project files as a `.zip` bundle and makes them available for downloading (the link is valid for 12 months).

```ruby
@client.download_files(project_id, params)  # Input:
                                        ## project_id (string, required)
                                        ## params (hash, required)
                                        ### :format (string, required) - one of the file formats supported by Lokalise (json, xml, po etc).
                                        ### Find the list of other supported params at https://developers.lokalise.com/reference/download-files
                                        # Output:
                                        ## Generic object with project id and a "bundle_url" link
```

For example:

```ruby
params = {
  format: 'yaml',
  original_filenames: true,
  filter_langs: ['fr', 'en']
}

response = @client.download_files project_id, params

response.bundle_url # => 'https://...'
```

Alternatively:

```ruby
project = @client.project project_id

response = project.download_files params
```

If you need a simple way to upload and download translation files in your Ruby scripts, take advantage of the [lokalise_manager gem](https://github.com/bodrovis/lokalise_manager).

## Download translation files (async)

[Doc](https://developers.lokalise.com/reference/download-files-async)

Downloads translation files asynchronously (in the background) and returns process ID.

```ruby
@client.download_files_async(project_id, params)  # Input:
                                                  ## project_id (string, required)
                                                  ## params (hash, required)
                                                  ### :format (string, required) - one of the file formats supported by Lokalise (json, xml, po etc).
                                                  ### Find the list of other supported params at https://developers.lokalise.com/reference/download-files
                                                  # Output:
                                                  ## QueuedProcess resource
```

For example: 

```ruby
process = @client.download_files_async PROJECT_ID, format: :json, original_filenames: false

process.process_id # => "123abc-..."

process = @client.queued_process PROJECT_ID, process.process_id
process.type # => 'async-export'
process.details['download_url'] # => 'https://...'
```

Alternatively:

```ruby
project = @client.project project_id

response = project.download_files_async params
```

## Upload translation file

[Doc](https://developers.lokalise.com/reference/upload-a-file)

Please note that file uploading is performed in the background.

```ruby
@client.upload_file(project_id, params) # Input:
                                        ## project_id (string, required)
                                        ## params (hash, required)
                                        ### :data (string, required) - base64-encoded data (the format must be supported by Lokalise)
                                        ### :filename (string, required)
                                        ### :lang_iso (string, required)
                                        ### Find the list of other supported params at https://developers.lokalise.com/reference/upload-a-file
                                        # Output:
                                        ## QueuedProcess resource
```

To encode your data in Base64, use `Base64.strict_encode64()` method.

After the uploading process is completed, a `QueuedProcess` resource will be returned. This resource contains a status of the import job, process ID to manually check the status, and some other attributes:

```ruby
params = {
  data: 'Base-64 encoded data... ZnI6DQogI...',
  filename: 'my_file.yml',
  lang_iso: 'en'
}

queued_process = @client.upload_file project_id, params

queued_process.status # => 'queued'
queued_process.process_id # => 'ff1876382b7ba81f2bb465da8f030196ec401fa6'
```

You can periodically reload data for the queued process and check the `status` attribute:

```ruby
reloaded_process = queued_process.reload_data # loads new data from the API
reloaded_process.status # => 'finished'
```

Alternatively, you may use the `queued_process` method:

```ruby
reloaded_process = @client.queued_process project_id, queued_process.process_id
```

It is up to you to decide how to poll API for changes (remember that larger files will take more time to be imported), but here's a simple example:

```ruby
def uploaded?(q_process)
  5.times do # try to check the status 5 times
    q_process = q_process.reload_data # load new data
    return(true) if q_process.status == 'finished' # return true is the upload has finished
    sleep 1 # wait for 1 second, adjust this number with regards to the upload size
  end

  false # if all 5 checks failed, return false (probably something is wrong)
end

params = {
  data: 'Base-64 encoded data... ZnI6DQogI...',
  filename: 'my_file.yml',
  lang_iso: 'en'
}

process = @client.upload_file project_id,

uploaded? process
```

Alternatively:

```ruby
project = @client.project project_id

process = project.upload_file params
```

If you need a simple way to upload and download translation files in your Ruby scripts, take advantage of the [lokalise_manager gem](https://github.com/bodrovis/lokalise_manager).

## Delete a file

[Doc](https://developers.lokalise.com/reference/delete-a-file)

This endpoint does not support "software localization" projects.

```ruby
@client.destroy_file(project_id, file_id) # Input:
                                          ## project_id (string, required)
                                          ## file_id (string or integer, required)
                                          # Output:
                                          ## Generic with project_id and "file_deleted" set to "true"
```

For example:

```ruby
response = @client.destroy_file project_id, file_id

response.file_deleted # => true
```

Alternatively:

```ruby
project = @client.project project_id

response = project.destroy_file file_id
```