# Umbrella

## Standard Workflow

 1. Set up the project: `bin/setup`
 1. Start the web server: `bin/server`
 1. As you work, remember to navigate to `/git` and **commit often as you work.**

## Handy links:

 - [JSONView Chrome extension](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en)
 - [Dark Sky forecast at the Merchandise Mart for humans](https://darksky.net/forecast/41.8887,-87.6355/us12/en)
 - Dark Sky forecast at the Merchandise Mart for machines:
 
     ```
     https://api.darksky.net/forecast/REPLACE_THIS_PATH_SEGMENT_WITH_YOUR_API_TOKEN/41.8887,-87.6355
     ```
 - [Dark Sky API docs](https://darksky.net/dev/docs)
 - [Map of Merchandise Mart for humans](https://goo.gl/maps/2mXdvBnHSGuMq98m6)
 - Map of Merchandise Mart for machines:

    ```
    https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=REPLACE_THIS_QUERY_STRING_PARAMETER_WITH_YOUR_API_TOKEN
    ```
 - [Google Geocoding API docs](https://developers.google.com/maps/documentation/geocoding/start)
 - [How to store secrets securely on Gitpod](https://chapters.firstdraft.com/chapters/792)

## Your tasks

 - Figure out how to turn an arbitrary street address (find a place that is [sort of rainy](https://www.rainviewer.com/) right now to test with) into a latitude/longitude using the Geocoding API.
 - Figure out how to turn a latitude/longitude pair into a weather forecast using the Dark Sky API.
   - Start by printing out the current temperature and the outlook for the next hour at the latitude/longitude.
   - The goal, however, is to check whether there is a >50% chance of precipitation at any point during the next 12 hours. If so, we will print "You should take an umbrella!"
   - Explore [the API documentation](https://darksky.net/dev/docs#forecast-request) to see what information is available to help you check this.
   - Something that might or might not be useful: [the `Time.at` method](https://apidock.com/ruby/Time/at/class).

        (Humans have [many, many different ways of representing dates](https://en.wikipedia.org/wiki/List_of_calendars). For the purposes of different pieces of software being able to agree on dates and times, most systems when talking to each other use [Epoch time](https://en.wikipedia.org/wiki/Unix_time) notation, or the number of seconds that have passed since midnight UTC on January 1st (minus leap seconds). Dark Sky, for example, includes times in this format. You can use `Time.at()` to convert to something more familiar, if you want to.)
 - Put all of the pieces together; given an arbitrary address:
    - print the current temperature
    - print outlook for the next hour
    - print whether a person should carry an umbrella.

## Example of how to send an email with the Mailgun gem

In your `Gemfile`, add:

```ruby
gem "mailgun-ruby"
```

Then, at a Terminal prompt:

```bash
bundle install
```

You will then have access to the `Mailgun::Client` class. It is used like this:

```ruby
# Retrieve your credentials from secure storage
mg_api_key = ENV.fetch("MAILGUN_API_KEY")
mg_sending_domain = ENV.fetch("MAILGUN_SENDING_DOMAIN")

# Create an instance of the Mailgun Client and authenticate with your API key
mg_client = Mailgun::Client.new(mg_api_key)

# Craft your email as a Hash with these four keys
email_parameters =  { 
  :from => "umbrella@appdevproject.com",
  :to => "put-your-own-email-address-here@example.com",  # Put your own email address here if you want to see it in action
  :subject => "Take an umbrella today!",
  :text => "It's going to rain today, take an umbrella with you!"
}

# Send your email!
mg_client.send_message(mg_sending_domain, email_parameters)
```

## Example of how to send an email with the Twilio gem

In your `Gemfile`, add:

```ruby
gem "twilio-ruby"
```

Then, at a Terminal prompt:

```bash
bundle install
```

You will then have access to the `Twilio::REST::Client` class. It is used like this:

```ruby
# Retrieve your credentials from secure storage
twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
twilio_sending_number = ENV.fetch("TWILIO_SENDING_PHONE_NUMBER")

# Create an instance of the Twilio Client and authenticate with your API key
twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

# Craft your SMS as a Hash with three keys
sms_parameters = {
  :from => twilio_sending_number,
  :to => "+19876543210", # Put your own phone number here if you want to see it in action
  :body => "It's going to rain today — take an umbrella!"
}

# Send your SMS!
twilio_client.api.account.messages.create(sms_parameters)
```

 - Sign up for your own Twilio account — [if use this referral link you'll $10 in credit](https://www.twilio.com/referral/86ykDX), and so will our class account.
 - [Twilio Ruby Quickstarts](https://www.twilio.com/docs/quickstart/ruby)

## Heroku Scheduler

If you get all that figured out, you might be interested in running your rake task automatically once per day, at say 6am.

It doesn't really make sense to do it on your own laptop, which might be switched off, or on Gitpod which also switches off after a period of inactivity (and they delete the workspace itself after not being used for two weeks).

What we should do is deploy our application to Heroku, where it will run forever even if left untouched. Then we, can use the [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler) add-on to run any rake task periodically.

It boils down to two commands:

```
heroku addons:create scheduler:standard
heroku addons:open scheduler
```

Then type the name of the rake task you want to run, and select how often you want it run from the dropdown menu. Voilà!
