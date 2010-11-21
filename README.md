# Charleston Ruby Collaborative Web Site

## What is it?

This project is our group website, and instead of creating a database driven site that contains people, projects, and pages we decided to empower the group members to fork this project, add their profiles, links to their projects, etc. on their own.

The project is a Sinatra application that parses files in the pages, people, and projects directory and serves them to the client.

It is really easy to create a project, profile or page, but for step by step 
instructions please see the sections below: 

## Getting Started

### Step 1 - Install Ruby

Make sure you have a recent Ruby and Rubygems installed.

Check out [ruby-lang.org](http://ruby-lang.org) for more details on getting Ruby and Rubygems installed.

### Step 2 - Fork and Clone the project

Make sure you have a GitHub account.

Then select fork from the project repository.

Then open a terminal and clone your newly forked project

    git clone git@github.com:[your github account]/colonial.git

Setup and fetch upstream repository

    git remote add upstream git://github.com/dirk/colonial.git
    git fetch upstream

### Step 3 - Install Gems and run app

Install Bundler and pull required gems

    gem install bundler
    bundle install

Run the application in development mode either do

    rackup
    
and go to http://localhost:9292 in your browser,

or run


    ruby app.rb -r rubygems
    
and go to http://localhost:4567 in your browser.

## How do I add my profile?

Follow the steps above to pull the project and setup your development environment.  

### Step 1 - Create Profile page

Next open up a text editor and create a new file for your profile in the people folder.

    touch people/[your nickname].haml
    
    touch people/[your nickname].erb

Then edit that file

    vim people/[your nickname].haml

Whether you prefer haml or erb, it is important to put a yaml header on your file, so the system can reconize it and create the link to your page. For people and projects, the header must have an attribute called `name`; for pages, the header must have an attribute called `title`. The `path` attribute is also available to change the URL path to something other than the filename without the extension.

    ---
    name: [You full name]
    path: [Optional; name other than that of your file]
    ---

Then below the header you are welcome to start building your page.

You can add your name, picture, projects, twitter, e-mail, etc.  Whatever you want to add is fine as long as it is appropriate and true.

Then run the application and make sure your profile is working and displaying how you like it.

### Step 2 - Send pull request

Ok you have worked on your page and now you are ready to get it up on the production site.

First you want to commit your changes to your local repository.

    git add .
    git commit -am "added my profile page to charleston ruby"

Next you want to push to your github repository

    git push origin master

Lastly, you want to send a pull request.

On you GitHub project page, click the pull request button and type in a message about your profile and account.  Then submit the request.

You should get a notification from the project maintainer when you changes have been pushed to production.

### Step 3 - Keep your repository in sync with the upstream version

Once you have been notified that your changes have been pushed, simply go to your project directory and run the following:

    git fetch upstream
    git merge upstream/master
    git push origin master

This will pull the upstream changes and push them on to your github repository, it is a good idea to do this anytime you want to start another host of changes
to the project.

## How do I add a project?

## How do I add a page?

## How to contribute?

Fork, change, commit, send pull-request, repeat.