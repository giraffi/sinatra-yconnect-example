[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Requirement

- YDN Application (Server side)
    - `ENV['YAHOOJP_KEY']`
    - `ENV['YAHOOJP_SECRET']`

## After deployment

You should add callback url to YDN Application like below.

```
https://{HEROKU_APPNAME}.herokuapp.com/auth/yahoojp/callback
```
