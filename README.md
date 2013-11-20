# Railtility

> Concerns, helpers and other utility snippets for your Rails applications

## What exactly is it ?

Simply put, it's a collection of files that you copy into your application's directory for extended functionality.

## And what does it do ?

For now, just a few things. Here's a list of them:

1. [Authentication](#authentication)
2. [Resourced controllers](#resourced)
3. [Scoped resources](#scopes)
4. [Model default values](#default-values)

## But shouldn't it be a Gem ?

Maybe. The reasons I made it the way it is are:

1. Easier to maintain, no external sources
2. Lightweight, fewer code is faster
3. Transparent, everything is right within your own codebase
4. Almost zero configuration, just copy a bunch and done
5. Modular, copy only what you want
6. Easier to understand and to customize

## But there are already great Gems for this kind of stuff.

Yes, and if you like them you should use them. I use them in my own projects and I learned so much from them. But I realized that most of the time you just need a few lines of fine code to do the trick.

---

# Features

## <a name="authentication"></a>Authentication

Provides session based authentication plus header based authentication. Comes with a tableless `Session` model that provides standard form errors and a few useful helpers.

The header based authentication provides simple HTTP authorization for requests with `Authorize` header.

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

1. Add the `bcrypt` Gem to your `Gemfile`
2. Add `include Authenticable` to your user model
3. Add `before_action :authenticate!` to all controllers that need to be secured
4. Add `resource :session` to your routes
5. Copy error messages `not_found` and `no_match` to your locale file

It assumes:

1. You have a model named `User`
2. You want to base the authentication on email and password
3. Your model has the columns `email` and `password_digest`

### Configuration

There's no configuration, but you can always change the files yourself to suit your needs.

### Alternatives

- [Devise](https://github.com/plataformatec/devise)
- [Authlogic](https://github.com/binarylogic/authlogic)

---

## <a name="resourced"></a>Resourced controllers

...

### Files

```
└── app
    ├── controllers
        └── concerns
            ├── resourced.rb
            └── scopable.rb
```

### Usage

...

### Configuration

...

### Alternatives

- [InheritedResources](https://github.com/josevalim/inherited_resources)

## <a name="scopes"></a>Scoped resources

Bring you model' scopes to your controller and access them via request parameters.

### Files

```
└── app
    ├── controllers
    │   ├── concerns
    │   │   ├── resourced.rb
    │   │   └── scopable.rb
    │   └── session_controller.rb
    ├── helpers
    │   └── authentication_helper.rb
    ├── models
    │   ├── concerns
    │   │   ├── authenticable.rb
    │   │   ├── authorable.rb
    │   │   └── has_default_values.rb
    │   └── session.rb
    └── views
        └── session
            ├── _form.html.erb
            └── new.html.erb
```
### Usage

...

### Configuration

...

### Alternatives

...


## <a name="default-values"></a>Model default values

...

### Files

```
└── app
    ├── controllers
    │   ├── concerns
    │   │   ├── resourced.rb
    │   │   └── scopable.rb
    │   └── session_controller.rb
    ├── helpers
    │   └── authentication_helper.rb
    ├── models
    │   ├── concerns
    │   │   ├── authenticable.rb
    │   │   ├── authorable.rb
    │   │   └── has_default_values.rb
    │   └── session.rb
    └── views
        └── session
            ├── _form.html.erb
            └── new.html.erb
```
### Usage

...

### Configuration

...

### Alternatives

...

---

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

See LICENSE