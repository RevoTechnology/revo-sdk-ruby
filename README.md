# RevoSDK

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'revo_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install revo_sdk

## Usage

To start working with Revo API you need to set `secret`, `store_id`, `redirect_url` and `callback_url` params. You may set it as follows:

```ruby
RevoSDK.configure do |c|
  c.store_id = 123
  c.secret = '4c97e12e1f37lm3006d552134543a3a7651b9743'
  c.callback_url = 'http://example.com/callback'
  c.redirect_url = 'http://example.com/redirect'
  c.log = true      # default value is false
  c.test = false    # default value is true
end
```

In Rails this configure method could also be moved to `initializers`, then all sensitive data should be stored in `Rails.secrets`.

RevoSDK implements four modules to access Revo API:

**RevoSDK::Limit**

Use it to access client's limit by phone.

```ruby
RevoSDK::Limit.phone('9031234567')

=> {"mobile_phone"=>'9031234567', "limit_amount"=>"9950.00", "status"=>"active"}
```

**RevoSDK::PreOrder**

Use it to access iframe link with initial service form.

```ruby
RevoSDK::PreOrder.get_iframe_url

=> "https://r.revoplus.ru/iframe/v1/form/302e6245644c1bf64b87awwefe9a8f2e9b89eef1"
```

**RevoSDK::Order**

Use it to access iframe link with order service form. You need to pass correct `amount` and `order_id` parameters to receive proper response on your service callback.

```ruby
RevoSDK::Order.get_iframe_url(199.99, 'OR12345')

=> "https://r.revoplus.ru/iframe/v1/form/302e6245644c1bf64b87awwefe9a8f2e9b89eef1"
```


**RevoSDK::ReturnOrder**

Use it make full or partial return on order.

```ruby
RevoSDK::ReturnOrder.proceed(49.99, 'OR12345')

=> { status: :ok }
```

Every module can be configured separately as follows:

```ruby
RevoSDK::Limit.configure do |c|
  c.store_id = 113
  c.secret = '4c97e12e1f37ff3006drt2134543a3a7651b9743'
  c.callback_url = 'http://example.com/callback'
  c.redirect_url = 'http://example.com/redirect'
  c.log = true      # default value is false
  c.test = false    # default value is true
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RevoTechnologies/revo-sdk-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

