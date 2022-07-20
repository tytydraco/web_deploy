# web_deploy

A Flutter package to quickly build a web release that is GitHub Pages ready.

## Features

* Depends only on `yaml` package
* Redirects to the `build/web/index.html` automatically

## Getting started

Add `web_deploy` to your project using `flutter pub add --dev web_deploy`.

## Usage

After adding `web_deploy` to your `pubspec.yaml` and configuring any settings, you can execute
the build program with the following command:

`flutter pub run web_deploy:main`

## GitHub Pages

Once the web release is generated, you can simply enable GitHub Pages in your project. An `index.html` file will be
created at the project root that will redirect the user to the web release page at `./build/web/index.html`. The page
should be accessible via: `https://<username>.github.io/<repo_name>`.
