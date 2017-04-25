# qna [![CircleCI](https://circleci.com/gh/JDTeamAcetabulum/qna.svg?style=shield)](https://circleci.com/gh/JDTeamAcetabulum/qna) [![Coverage Status](https://coveralls.io/repos/github/JDTeamAcetabulum/qna/badge.svg)](https://coveralls.io/github/JDTeamAcetabulum/qna) [![Zenhub](https://raw.githubusercontent.com/ZenHubIO/support/master/zenhub-badge.png)](https://zenhub.com)

Welcome to the QNA project! This is a web application that enables instructors to ask students questions, either in class (via "live questions") or out of class. It was originally developed an alternative to the Turing Point Clicker system used at the Georgia Institute of Technology.

## Getting Started

It is possible to run the app by running it locally, or by deploying it to [Heroku](heroku.com). The following instructions are for running the app locally.

### Dependencies

You will need to install the following dependencies. Please refer to the installation instructions for each. This application has been tested with the version numbers indicated, though later versions may also work.

* [Ruby](https://www.ruby-lang.org) version `2.2.2` with [Rails](http://rubyonrails.org/) version `5.0.1` and [bundler](http://bundler.io/) version `1.14.4`
* [Postgresql](https://www.postgresql.org/) version `9.5.6`
* [node.js](https://nodejs.org) version `7.9.0` and npm (included)

### Installation

To install the app itself, download the latest release from [Github releases](https://github.com/JDTeamAcetabulum/qna/releases) or [clone this repository](https://help.github.com/articles/cloning-a-repository/) for the current development version and complete the following steps.

1. Run `bundle install` to install the dependencies for Ruby/Rails (listed in `Gemfile`).
1. Run `npm install` to install the necessary dependencies for node.js.
1. Run `rails db:setup && rails db:migrate` to set up the database and run migrations.

### Running

Run the web server with `rails server`. The server will automatically use the port indicated by the `PORT` environment variable, or port 3000 if no port is set.

Run the test suite with `rails test`.

### Troubleshooting

If the application encounters an error in production, a detailed application trace will be found in `log/` with a timestamp. If an error is encountered locally, the server will serve a page with a detailed application trace which mirrors the one found in the terminal running `rails s`. It is reccommended to use a `debugger` statement anywhere in the code to debug. Rails will pause execution at the `debugger` statement and give a CLI to run debugging statements in the terminal running `rails s`. More information about the debugger can be found [here](http://guides.rubyonrails.org/debugging_rails_applications.html).
