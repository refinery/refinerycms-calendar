# Refinery CMS Calendar extension

[![Build Status](https://travis-ci.org/refinery/refinerycms-calendar.svg?branch=master)](https://travis-ci.org/refinery/refinerycms-calendar)

## Install

Add this line to your application's `Gemfile`

```ruby
gem 'refinerycms-calendar', '~> 3.0.0'
```

Next run

```bash
bundle install
rails generate refinery:calendar
rake db:migrate
rake db:seed
```

Now when you start up your Refinery application.