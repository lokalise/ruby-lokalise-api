---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---

# Lokalise APIv2 Ruby interface

Install the gem:

    gem install ruby-lokalise-api

Obtain Lokalise API token in your personal profile, initialize and use the client:

{% highlight ruby %}
require 'ruby-lokalise-api'

@client = Lokalise.client 'YOUR_TOKEN_HERE'

project = @client.project '123.abc'
project.name

process = @client.upload_file project_id,
                              data: 'Base-64 encoded data... ZnI6DQogI...',
                              filename: 'my_file.yml',
                              lang_iso: 'en'

process.status
{% endhighlight %}

Looking for a Rails integration? Try the [lokalise_rails gem](https://github.com/bodrovis/lokalise_rails). Also you can use a [lokalise_manager gem](https://github.com/bodrovis/lokalise_manager) which allows to exchange translation files between Lokalise and *any* Ruby script.

## Usage

<nav class="index">
  {% include nav_full.html %}
</nav>

## Additional info

<nav class="index">
  {% include nav_full_additional.html %}
</nav>
