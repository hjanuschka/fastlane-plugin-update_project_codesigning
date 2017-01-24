# update_project_codesigning plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-update_project_codesigning)
![](http://ruby-gem-downloads-badge.herokuapp.com/fastlane-plugin-update_project_codesigning)

## About

Updates the Xcode 8 Automatic Codesigning Flag



## Add Plugin

```bash
fastlane add_plugin update_project_codesigning
```


## Example

*Set Codesigning to manual on all targets*

```ruby
  update_project_codesigning(
    path: "demo-project/demo/demo.xcodeproj",
    use_automatic_signing: false
  )
```

*Set Codesinging to automatic*


```ruby
  update_project_codesigning(
    path: "demo-project/demo/demo.xcodeproj",
    use_automatic_signing: true
  )
```

*Only for specific targets*

```ruby
  update_project_codesigning(
    path: "demo-project/demo/demo.xcodeproj",
    use_automatic_signing: false,
    targets: ["demo"]
  )
```

*Also set team-id*

```ruby
  update_project_codesigning(
    path: "demo-project/demo/demo.xcodeproj",
    use_automatic_signing: true,
    team_id: "XXXXX"
  )
```


## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use 
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/PluginsTroubleshooting.md) doc in the main `fastlane` repo.

## Using `fastlane` Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Plugins.md).

