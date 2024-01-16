---
layout: post
title: Easy instructions for installing Jekyll 
date: '2023-02-01T10:00:15+00:00'
permalink: easy-installation-instructions-for-jekyll
image: BlogPost-4.jpg
categories: [ Jekyll, Tutorial ]
featured: true
comments: false 
---
# *This post is still a work in progress as of 11/30/2023*

The goal for this blog post is to provide easy instructions for installing Jekyll. 

If you follow these steps, you should be able to create a new Jekyll web site utilizing GitHub and GitHub Pages to host your repository and web site.

We will walk you through the process of cloning the repository, making some changes to the site to configure it to be your own, and then ultimately getting your website published using your own custom domain name. 

A couple of assumptions to start:
1. [You have a GitHub account created](https://github.com/signup).
2. You have already purchased a custom domain name to use (you can bypass this and create a site using SITENAME.github.io)
3. You have Git tools installed (if you're using Windows, use Git For Windows)
4. You have [Visual Studio Code](https://code.visualstudio.com/) installed, or some other text editor that you're comfortable with.

## Precursor
This page is a work in progress, if you find something missing or wrong, let me know! [You can create an issue on the GitHub repo!](https://github.com/ChrisHammond/jekyllexample.github.io/issues)

## Instructions

1. Create a new Organization on GitHub  
    - A free organization account will be sufficient. For our example organization, we will used JekyllExampleWeb (JekyllExample was already taken).  
    - Creating a new organization for each custom domain name you are going to use makes it easier to setup and manage multiple sites. You theoretically could get by with [one Organization or just multiple projects under your user account](https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages#types-of-github-pages-sites), but I find it easier to manage multiple sites this way.
2. [Create a new repository based off the JekyllExample repository](https://github.com/ChrisHammond/jekyllexample.github.io/generate)  
    - While logged into GitHub, you should see a button that says "Use this template" next to the Code button in the JekyllExample repo, creating on the Use this template button will allow you to create a fork that is disconnected from the original repo and doesn't bring over all the change history.
    - Be sure to check the "Include all branches" option when doing this, otherwise MAIN won't come over and the workflow won't work.
3. Rename the repository to match the domain name that you want to use for GitHub Pages  
    - As soon as you fork the repository, you can rename it. You will want to rename it to match the domain name that you want to use for GitHub Pages, for example we use jekyllexample.com, so the repository is jekyllexample.github.io. 
4. Clone the repository to your local machine for editing  
    - You can clone the repository to your local machine using the following command, (assuming you have Git installed, start up Git Bash and then navigate to the folder where you want to clone the repository to)
    ```bash
    git clone https://github.com/ORGANIZATION/SITENAME.github.io.git
    ```
    - Where SITENAME is the name of your repository that you modified in Step 3.
5. Open the repository in Visual Studio Code
    - You can open the repository in Visual Studio Code using the following command:
    ```bash
    code SITENAME.github.io
    ```
    - Where SITENAME is the name of your repository that you modified in Step 3. 
6. Navigate to the Repository Settings in GitHub
    - Navigate to the Actions/General Settings
        - Under Workflow Permissions be sure to choose "Read and write permissions" for the Actions workflow to be able to push changes to the repository. (*If you are unable to set this, try changing it at the Organization level first, then this individual repo*)

7. Change the _config.yml file
    - This file has a number of variables for options for your site, such as Title, Description, Author, etc. You will want to customize these to start to brand and name your site.
    - If you're using Google Analytics you can configure the MEASUREMENT ID here as well.
8. Edit the CNAME file in the root of the repository to match your custom domain name
    - If you're not using a custom domain name, you can delete this file.
9. Commit your changes to the GitHub repository and push them.
    ```bash
    git add .
    git commit -m "Some updated comment about the commit here"
    git push
    ```
    - You may be prompted to configure your GitHub credentials at this point, [here's an approach on how to do that](https://stackoverflow.com/questions/46878457/adding-git-credentials-on-windows).
10. Configure the repository settings for GitHub Pages and Workflow to allow for deployment
    - In the GitHub Repository Settings, you will want to configure the following:
        - Under the GitHub Settings find the GitHub Pages section
        - Under Source choose "Deploy from a branch"
        - Under Branch choose "main" and "/(root)"
11. Configure your DNS for your domain to point to GitHub pages
    - You will need to do this before step 10 so that GitHub can verify and find your custom domain name configured properly. 
    - You basically need to setup A records for your domain name that point to the following IP addresses:
        - 185.199.108.153
        - 185.199.109.153
        - 185.199.110.153
        - 185.199.111.153
    - I use CloudFlare for my domains, so the DNS entries are configured as follows:
    {% picture cloudflaredns.jpg --alt DNS Settings for CloudFlare  %}
    - You would replace jekyllexample.com with your domain in your DNS settings. 
12. Configure your custom Domain Name
    - Under the GitHub Settings find the GitHub Pages section
    - Under Custom Domain, enter your custom domain name (ex: jekyllexample.com)
13. Navigate to the Actions tab in the GitHub interface
    - You should see your commit that you pushed in step 8, and you should see a workflow that is running (or has ran).
    - After that you should see a second action that is running (or has ran) something like "pages build and deployment"
    - If both of those actions have completed successfully, you should be able to navigate to your custom domain name and see your site.
14. Next steps! Edit the blog posts in the _posts folder, or delete them and create your own posts.
    - The easiest way to create a new post is to simply copy and paste one of the existing posts
        - Rename the file to match the date and title of your post
        - Edit the file to change the content/title and importantly be sure to update the published date to the dat you want the post to be.
        - Commit and push your changes to GitHub and you should see your new post on your site after the workflow completes.

