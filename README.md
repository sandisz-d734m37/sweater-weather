# Welcome to Sweater Weather!
#### or is it Whether Sweater?
<hr>

### Sweater Weather is an API that allows users to plan road trips and determine what the weather may be like upon arrival at the destination location.

In other words, users can determine whether they ought to bring a sweater, based on weather.

<hr>

## How to: initial set up

1. Clone down this repository down by running this command in your terminal:
  `$ git clone git@github.com:sandisz-d734m37/sweater-weather.git`
2. Navigate into your newly cloned directory
3. Install all of the necessary gems by runnning `$ bundle install` in your terminal
4. Set up the database by running `$ rails db:create` then `$ rails db:migrate` in yout terminal
5. At this point, you'll have to __get a few API keys of your own!__

## How to: API keys

Sweater Weather makes use of __three external API__, all of which __require their own API keys__. Here, I'll lead you to where you need to go to get your very own API key!

#### [Bing Image Search API]([https://www.google.com](https://www.microsoft.com/en-us/bing/apis/bing-image-search-api)) - just click the `try now` button and follow the steps to create an account

#### [MapQuest GeoCoder and Directions API](https://developer.mapquest.com/user/login/sign-up) - Follow the steps to sign up and get your API key

#### [OpenWeather API key](https://home.openweathermap.org/users/sign_up) - Follow the steps to sign up and get your API key

- Once you've got your API keys, open `config/application.yml` in your text editor.
- Here, you'll make yout API keys into private, environment variables. Follow the format below to fill in you `config/application.yml` file. While your API keys will, of course, be unique it is __*very important*__ your `config/application.yml` file follows this __*exact*__ format. Otherwise, the application __*will not work*__.

```
MAPQUEST_API_KEY: <your MapQuest API key>
WEATHER_API_KEY: <your OpenWeather API key>
BING_API_KEY: <your Bing (AKA Azure) API key>
```

## How to: Your endpoints
#### _Note: this app was made for learning purposes only and only works in the local environment, specifically: `localhost:5000`_

### At this point, your cloned version of Sweater Weather should be in working order!

If you'd like to check, you can run `$ bundle exec rspec` in your terminal and you should see about 61 tests pass!

### First things first: start up your sever

You can start your server by simply running `$ rails s` in your terminal!
You can halt your server at any time by pressing `ctrl c` in your terminal. Note: you will have to start up your server again hit any of the endpoints below

### User Registration endpoint

Sweater Weather runs on the port `localhost:5000`, so all of your endpoints will use this as our URL

Open up `PostMan`, or whatever app you use to hit API endpoints

For this enpoint, we'll be sending a `POST` request which should look like this:
```
POST localhost:5000/api/v1/users
```
(meaning select `POST` on the dropdown to the left of your address bar, then copy and paste that `URI` into ypur addrsss bar (or whatever app you've chosen to use) __*while your server is running*__)

Before hitting `send`, you'll have to send some params in the body!

To do this in `PostMan`, navigate to `Body` (this option is just below your address bar)
From here, select `raw` then in the dropdown you'll see to the right, select `JSON`

In the text box you'll see, add your user information like this:

```
{
    "email": "your_email",
    "password": "your_password",
    "password_confirmation": "your_password"
}
```

__*The brackets and questions are required!*__

Now, click send and you should see something like this:

```
{
    "data": {
        "id": 6,
        "type": "user",
        "attributes": {
            "email": "your_email",
            "api_key": "<your brand new, totally unique Sweater weather API Key>"
        }
    }
}
```

### User log in/session creation endpoint

The steps here are pretty similar to the ones above, minus the `password_confirmation`

Here, you'll once again send a `POST` request like this:

```
POST localhost:5000/api/v1/sessions
```

Before hitting send, add this info to your `Body` just like you did before:

```
{
    "email": "your_email",
    "password": "your_password"
}
```

If your password was correct and your email exists, you should once again see a response like this:

```
{
    "data": {
        "id": 6,
        "type": "user",
        "attributes": {
            "email": "your_email",
            "api_key": "<your brand new, totally unique Sweater weather API Key>"
        }
    }
}
```

### Retrieving weather for a location

You don't actually need your Sweater Weather API key for this, but don't lose track of it as you'll need it later!

This time, you'll do a `GET` request. In the dropdown to the left of your address bar, select `GET` and put something like this into the address bar:

```
GET localhost:5000/api/v1/forecast?location=<your desired location>
```

Hit send and you should see a response like this:

```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "06/15/22 at 05:49:56 UTC",
                "sunrise": "06/14/22 at 11:31:26 UTC",
                "sunset": "06/15/22 at 02:29:10 UTC",
                "temperature": 58.21,
                "feels_like": 56.12,
                "humidity": 51,
                "uvi": 0,
                "visibility": 10000,
                "conditions": "clear sky",
                "icon": "01n"
            },
            "daily_weather": [
                {
                    "date": "06/14/22",
                    "sunrise": "06/14/22 at 11:31:26 UTC",
                    "sunset": "06/15/22 at 02:29:10 UTC",
                    "max_temp": 86.83,
                    "min_temp": 58.95,
                    "conditions": "few clouds",
                    "icon": "02d"
                },
                {
                    "date": "06/15/22",
                    "sunrise": "06/15/22 at 11:31:26 UTC",
                    "sunset": "06/16/22 at 02:29:34 UTC",
                    "max_temp": 88.25,
                    "min_temp": 56.08,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "06/16/22",
                    "sunrise": "06/16/22 at 11:31:29 UTC",
                    "sunset": "06/17/22 at 02:29:56 UTC",
                    "max_temp": 93.92,
                    "min_temp": 64.8,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "06/17/22",
                    "sunrise": "06/17/22 at 11:31:33 UTC",
                    "sunset": "06/18/22 at 02:30:16 UTC",
                    "max_temp": 96.82,
                    "min_temp": 69.31,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "06/18/22",
                    "sunrise": "06/18/22 at 11:31:39 UTC",
                    "sunset": "06/19/22 at 02:30:34 UTC",
                    "max_temp": 97.47,
                    "min_temp": 71.47,
                    "conditions": "light rain",
                    "icon": "10d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "05:00:00 UTC",
                    "temperature": 58.95,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "06:00:00 UTC",
                    "temperature": 58.21,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "07:00:00 UTC",
                    "temperature": 58.35,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "08:00:00 UTC",
                    "temperature": 58.21,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "09:00:00 UTC",
                    "temperature": 57.76,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "10:00:00 UTC",
                    "temperature": 57.02,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "11:00:00 UTC",
                    "temperature": 56.08,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "12:00:00 UTC",
                    "temperature": 56.79,
                    "conditions": "clear sky",
                    "icon": "01d"
                }
            ]
        }
    }
}
```

### Retrieving a background image
This can be used to give you an image related to a city you're looking for!

This is another `GET` request. In your address bar, enter something like this:

```
GET localhost:5000/api/v1/backgrounds?location=<your desired location>
```

Hit Send and you should see a response like this:

```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "image": {
                "location": "denver,co",
                "image_url": "https://meetingsource.com/wp-content/uploads/2017/01/Denver_345958679.jpg",
                "credit": {
                    "source": "https://meetingsource.com/listing/denver",
                    "author": null,
                    "logo": null
                }
            }
        }
    }
}
```

### Creating a road trip
Here we are, the real functionality of our lovely application.

This is another `POST` request, so make sure you've selected `POST` in thart dropdown we've talked so much about.

Now put this into your address bar:

```
POST localhost:5000/api/v1/road_trip
```

Before hitting send, add this info to your `Body` just like you did before:

```
{
    "origin": "denver,co",
    "destination": "new york,ny",
    "api_key": "<your Sweater Weather API key>"
}
```

And you should see a response just like this:
```
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver, CO",
            "end_city": "New York, NY",
            "travel_time": "26:07:39",
            "weather_at_eta": {
                "temperature": 74.88,
                "conditions": "light rain"
            }
        }
    }
}
```

### Going on a road trip

At this point, you'll want to determin whether you need a sweater based on the weather provided in the previous response.

Grab your sweater after you determined whether you need it or not, based on the weather.

`GET` into your or a friends car

`go`
