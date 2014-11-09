# Railtility

> Concerns, helpers and other utility snippets for your Rails applications.

## What exactly is it ?

Simply put, it's a collection of files that you selectively copy into your application to extend its functionality.

## And what does it do ?

The components are:

1. [Authentication](#authentication)
2. [Scopable](#scopable)
3. [Default values](#default-values)
4. [Breadcrumb](#breadcrumb)
5. [Ownership](#ownership)
6. [Authorship](#authorship)

## But shouldn't it be a Gem ?

Maybe. A few reasons I made it the way it is are:

1. Easier to maintain, no external sources
2. Lightweight, fewer code is faster
3. Transparency and control, everything is in your own codebase
4. Almost zero configuration, just copy a bunch of files and you're ready to go
5. Modular, copy only what you want
6. Makes it easier to understand and to maintain

## But there are great Gems for this kind of stuff.

Yes, and if they fit your needs you should totally use them. I for one use them and learn a lot from them. But most of the time they are simply too much, when just a couple of lines of code would do the trick for me, so I think it's about trade-offs.

---

# Features

## Authentication

Provides session and [Basic HTTP](http://en.wikipedia.org/wiki/Basic_access_authentication) authentication. Also comes with a `Session` model that provides standard model validation, and a few helpers.

### Files

```
└── app
    ├── controllers
    │   └── session_controller.rb
    ├── helpers
    │   └── authentication_helper.rb
    ├── models
    │   ├── concerns
    │   │   └── authenticable.rb
    │   └── session.rb
    └── views
        └── session
            ├── _form.html.erb
            └── new.html.erb
```

### Usage

Copy the aforementioned files into your application, then:

1. Make sure `bcrypt` is in your `Gemfile`
2. Add `include Authenticable` to your user model
3. Add `before_action :authenticate` to all the controllers that need to be secured
4. Add session routes to your application (see `config/routes.rb` for reference)
5. Add custom error messages to your locale file (see `config/locale/en.yml` for reference)

It assumes:

1. You have a model named `User`
2. You want to identify by user's email and authenticate with a password
3. Your model has the columns `email` and `password_digest`

Note that it doesn't include e-mail confirmation or recover password feature.

### Alternatives

- [Devise](https://github.com/plataformatec/devise)
- [Authlogic](https://github.com/binarylogic/authlogic)

## Scopable

Scope your resource based on request parameters.

### Files

```
└── app
    └── controllers
        └── concerns
            └── scopable.rb
```
### Usage

Setup scopes using the `scope` method inside your controller's class:

```ruby
scope :search, :param => :q
```

Then, apply the scopes to your model when assigning it to a variable.

```ruby
@posts = scoped(Post, params)
```

Whenever `params[:q]` is present, it will use the `search` scope on your model passing the value of the parameter as argument.

Note that the scopes are chain-able, thus the order in which they're defined matters.

Optionally, you can provide more options to the scope:

```ruby
scope :search,
```

### Alternatives

- [has_scope](https://github.com/plataformatec/has_scope)

## Default values

### Files

```
└── app
    └── models
        └── concerns
             └── default_values.rb
```

### Usage

In your model's class:

```ruby
default_value_for :today do
  Time.zone.today
end
```

It will be lazily evaluated when the model is initialized.

## Ownership

Use properly named methods to create an ownership relation between models.

### Files

```
└── app
    └── models
        └── concerns
             └── ownership.rb
```

### Usage

Add `belongs_to_owner` to your owned model, and `owns_many` or `owns_one` to your owner model. These methods assumes that your owner model is actually named `User`, but you may customize this.

## Authorship

Use properly named methods to create an authorship relation between models.

### Files

```
└── app
    └── models
        └── concerns
             └── authorship.rb
```

### Usage

Add `belongs_to_author` to your owned model, and `authors_many` or `authors_one` to your author model. These methods assumes that your author model is actually named `User`, but you may customize this.

---

# Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

---

# License

See LICENSE
