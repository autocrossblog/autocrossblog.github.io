# JekyllExample.com

Welcome to JekyllExample! A template repository for getting a simple blog up and running on Jekyll using GitHub and GitHub Pages for publishing the site.

Using this template you can get a simple blog up and running, hosted on GitHub pages, with a custom domain. This template is designed to be easy to use and easy to customize.

## Basics
This is a Jekyll installation, thru GitHub Workflows/Actions an automated deployment occurs every time you check in code to the DEV (make this your default) branch. After a commit occurs, the pipeline begins by installing Ubuntu and a couple of necessary libraries. The Jekyll application runs and creates the static content for your site which is then committed to the main branch and published to GitHub Pages through a deployment. Depending on the site of your site (content/images), this can take a few minutes to complete.

## How To Get Started
To get started please read our tutorial blog post [How to use this repository](http://www.jekyllexample.com/easy-installation-instructions-for-jekyll)

## Issues 
If you run into issues, [please open an issue on this repository](https://github.com/ChrisHammond/jekyllexample.github.io/issues).

## Discussion
If you have questions on the repository, feel free to [jump into our Discussions area to ask a question](https://github.com/ChrisHammond/jekyllexample.github.io/discussions).

### Copyright

Copyright (C) 2022-2023 [Christoc.com](https://www.christoc.com/)

## Release Notes
This file will contain high level release notes, you can find [individual commits with perhaps more detailed notes](https://github.com/ChrisHammond/jekyllexample.github.io/commits/dev).

### 9/3/2023 
- Updated Workflow to use Ruby 3 to fix Gemfile.lock issues
