# web_deploy

A Flutter package to quickly build a web release that is GitHub Pages ready.

## Features

* Depends only on `yaml` package
* Redirects to the `build/web/index.html` automatically

## Install

There are two ways to install `web_deploy`. It can be installed to a project locally, such that others who clone your source
code will fetch `web_deploy` automatically as part of the developer dependencies. It can also be installed globally so
that `web_deploy` does not need to live in your source code, but instead lives on your system.

### For a specific project

Simply add web_deploy to your developer dependencies for your project: `dart pub add --dev web_deploy`.

### Global

If you already have Dart installed, simply activate the package globally:

```shell
dart pub global activate web_deploy
```

## Usage

After adding `web_deploy` to your `pubspec.yaml` and configuring any settings, you can execute
the build program with the following command:

`flutter pub run web_deploy:main`

or

`web_deploy`

## GitHub Pages

Once the web release is generated, you can simply enable GitHub Pages in your project. An `index.html` file will be
created at the project root that will redirect the user to the web release page at `./build/web/index.html`. The page
should be accessible via: `https://<username>.github.io/<repo_name>`.
