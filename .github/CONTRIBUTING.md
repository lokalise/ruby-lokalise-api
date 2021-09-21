# Contributing

1. [Fork the repository.][fork]
2. [Create a topic branch.][branch]
3. Implement your feature or bug fix.
4. Don't forget to add specs and make sure they pass by running `rspec .`.
5. Make sure your code complies with the style guide by running `rubocop`. `rubocop -a` can automatically fix most issues for you. Run `rubocop -A` to make it more aggressive.
6. If necessary, add documentation for your feature or bug fix.
7. Commit and push your changes.
8. [Submit a pull request.][pr]

[fork]: http://help.github.com/fork-a-repo/
[branch]: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-branches
[pr]: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-requests

## Previewing the docs locally

1. Clone the repo.
2. `cd docs`
3. `bundle exec jekyll serve --baseurl=''`.
4. Navigate to `http://localhost:4000` and observe the docs.
