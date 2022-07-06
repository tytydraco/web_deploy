# web_deploy
A development tool to build a web release that is GitHub Pages ready.

## Features

* Depends only on `yaml` package
* Configurable

## Getting started

Add `web_deploy` to your project using `flutter pub add --dev web_deploy`.

## Configuration

Configuration is done underneath the `web_deploy` tag in your `pubspec.yaml` file:

```yaml
dependencies:
  ...

dev_dependencies:
  ...

flutter:
  ...

web_deploy:
    release: true,          # Optional, builds for release
    web_renderer: html,     # Optional, forces the HTML web renderer
    index_redirect: true,   # Optional, creates index.html redirect to ./build/web/index.html
                            # in the project root
```

## Usage

After adding `web_deploy` to your `pubspec.yaml` and configuring any settings, you can execute 
the build program with the following command:

`flutter pub run web_deploy:main`

## GitHub Pages

Once the web release is generated, you can simply enable GitHub Pages in your project. If the 
`index_redirect` setting was enabled, an `index.html` file will be created at the project root that
will redirect the user to the web release page at `./build/web/index.html`. The page should be 
accessible via: `https://<username>.github.io/<repo_name>`, or 
`https://<username>.github.io/<repo_name>/build/web` if `index_redirect` was disabled.
