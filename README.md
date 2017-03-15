# qna [![CircleCI](https://circleci.com/gh/JDTeamAcetabulum/qna.svg?style=shield)](https://circleci.com/gh/JDTeamAcetabulum/qna) [![Coverage Status](https://coveralls.io/repos/github/JDTeamAcetabulum/qna/badge.svg)](https://coveralls.io/github/JDTeamAcetabulum/qna) [![Zenhub](https://raw.githubusercontent.com/ZenHubIO/support/master/zenhub-badge.png)](https://zenhub.com)

This application is meant to serve as an alternative to the Turing Point Clicker
system used at the Georgia Institute of Technology.

# Getting Started

You will need:
 * Ruby version `2.2.2`
 * Rails version `5.0.1`
 * Postgresql version `9.5.6`
 * npm

To install, first clone to repo locally. Run `bundle install` to install all
the necessary dependencies (listed in `Gemfile`). Also run `npm install` to
install the necessary `npm` dependencies.

When the above is completed, you simply need to migrate the database and run
the app. Migrate the database by running `rails db:setup && rails db:migrate`.
Then simply run the app using `rails s`.

To run the test suite: `rails test`
