# Releasing

1. Update the version in the gemspec (and the factory\_bot version, if necessary)
   and run `bundle install`
1. Update `NEWS.md` to reflect the changes since last release.
1. Commit changes.
   There shouldn't be code changes,
   and thus CI doesn't need to run,
   so you can add "[ci skip]" to the commit message.
1. Tag the release: `git tag -s vVERSION`
    - We recommend the [_quick guide on how to sign a release_] from git ready.
1. Push changes: `git push && git push --tags`
1. Build and publish:
    ```bash
    gem build factory_bot_rails.gemspec
    gem push factory_bot_rails-VERSION.gem
    ```
1. Add a new GitHub release using the recent `NEWS.md` as the content. Sample
   URL: https://github.com/thoughtbot/factory_bot_rails/releases/new?tag=vVERSION
1. Announce the new release,
   making sure to say "thank you" to the contributors
   who helped shape this version!

[_quick guide on how to sign a release_]: http://gitready.com/advanced/2014/11/02/gpg-sign-releases.html
