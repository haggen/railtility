# Railtility

> Concerns, helpers and other utility snippets for your Rails applications

## What exactly is it ?

Simply put, it's a collection of files that you copy into your application's directory for extended its functionality.

## And what does it do ?

The components are:

1. [Authentication](#authentication)
2. [Resourced](#resourced)
3. [Scopable](#scopable)
4. [Model dynamic default values](#default-values)
5. [Breadcrumb](#ownership)
6. [Ownership](#ownership)
7s. [Authorship](#authorship)

## But shouldn't it be a Gem ?

Maybe. The reasons I made it the way it is are:

1. Easier to maintain, no external sources
2. Lightweight, fewer code is faster
3. Transparency, everything is in your own codebase
4. Almost zero configuration, just copy a bunch of files and done
5. Modular, copy only what you want
6. Makes it easier to understand and to maintain

## But there are great Gems for this kind of stuff.

Yes, and if they fit your needs you should totally use them. I for one use them and learn a lot from them. But most of the time they are simply too much, and just a couple of lines of code would do the trick for you. It's all about cost-benefit.

---

# Features

## <a name="authentication"></a>Authentication

Provides session based authentication plus header based authentication. Comes with a `Session` model that provides standard form errors and a few useful helpers.

The header based authentication provides [basic HTTP authentication](http://en.wikipedia.org/wiki/Basic_access_authentication) for requests with `Authorize` header.

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
3. Add `before_action :authenticate` to all controllers that need to be secured
4. Add `resource :session` to your routes  (see `config/routes.rb` for reference)
5. Add custom error messages `not_found` and `no_match` to your locale file (see `config/locale/en.yml` for reference)

It assumes:

1. You have a model named `User`
2. You want to base the authentication on email and password
3. Your model has the columns `email` and `password_digest`

Unfortunetely it does not include e-mail confirmation nor forgot password features. But it will in the future.

### Alternatives

- [Devise](https://github.com/plataformatec/devise)
- [Authlogic](https://github.com/binarylogic/authlogic)

---

## <a name="resourced"></a>Resourced

Extendable resource handling for your RESTful controllers.

### Files

```
└── app
    └── controllers
        └── concerns
            ├── resourced.rb
            └── scopable.rb
```

### Usage

Copy the aforementioned files to your application directory and then create your controllers based on the example located in `app/controllers/posts_controller.rb`.

Please checkout the `resourced.rb` file, it's pretty straigth forward and also has comments on every method. Override them at will.

Please note that **Resourced** component depends on the **Scopable** component.

### Alternatives

- [InheritedResources](https://github.com/josevalim/inherited_resources)

## <a name="scopable"></a>Scopable

Bring you model' scopes to your controller and access them via request parameters.

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

Whenever `params[:q]` is present, it will call `search` on your resource collection passing the value of the parameter as the only argument.

Of course you can further customize its behavior:

```ruby
scope do |resource, value, controller|
  # ...
end
```

When you provide a block it'll be used as proxy to your resource collection.

Again checkout the source in `scopeable.rb` to see all the possible options.

### Alternatives

- [has_scope](https://github.com/plataformatec/has_scope)

## <a name="default-values"></a>Model default values

...

### Files

```
└── app
    └── models
        └── concerns
             └── default_values.rb
```
### Usage

Inside your model's class:

```ruby
default_value_for :today do
  Date.today
end
```

It will be lazily evaluated when the model is initialized.

---

## <a name="ownership"></a>Ownership

### Usage

...

## <a name="authorship"></a>Authorship

### Usage

...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

See LICENSE