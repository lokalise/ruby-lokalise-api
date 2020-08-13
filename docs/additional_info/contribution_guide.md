# Contributing

1. [Fork the repository.][fork]
2. [Create a topic branch.][branch]
3. Implement your feature or bug fix.
4. Don't forget to add specs and make sure they pass by running `rspec .`.
5. Make sure your code complies with the style guide by running `rubocop`. `rubocop -a` can automatically fix most issues for you.
6. If necessary, add documentation for your feature or bug fix.
7. Commit and push your changes.
8. [Submit a pull request.][pr]

[fork]: http://help.github.com/fork-a-repo/
[branch]: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-branches
[pr]: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-requests

## Running tests

1. Copypaste `.env.example` file as `.env`. Put your API token inside. The `.env` file is excluded from version control so your token is safe. All in all, we use pre-recorded VCR cassettes, so the actual API requests won't be sent. However, providing at least some token is required.
3. Run `rspec .`. Observe test results and code coverage.
