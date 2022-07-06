# Instructions

Here are some instructions explaining how I developed this project.

## Crawler

UrHouseCrawler have limited option, it's strict to the condition:  

```text
city: "taipei" or "new taipei"，
Type: 住宅(residential)，
Rent:NTD 30000 - 100000, 
sort from low to hight`
```

The params are city and page

```ruby
# get datas from https://www.urhouse.com.tw/
UrHouseCrawler.new(city: 'new taipei', page: 2).perform
```

If you want to save those data into DB
Please use `GetResidencesService`

```ruby
GetResidencesService.new(city: 'taipei', size: 15).perform
```

This service wrap `UrHouseCrawler` and is used in seed file, to save data and images of residences.

Duo to the development time limit, I hardcode the request URL in the codebase and the URL query string is encoded.(see `app/services/ur_house_crawler.rb`)

The requested URL is called after submitting the filter form.  
I got it from the chrome console directly.

A better solution might be to implement a real-time crawler using Selenium or a similar framework.

## Grape API

```ruby
  gem 'grape'
  gem "grape-entity"
```

`grape-entity` is for formating response date.

### Versioning

All grape endpoints are currently put in `app/api/v1` folders.

Each resource has its folder, e.g. user, residence, favorite_list

`app/api/v1/base.rb` for mounting all entry points.

If we need to use other versions, create a `v2` folder and put new entry points in it.

### Authentication

This project is API mode

`rails new new_project --api`  

it closes session and cookie feature

I developed token-based authentication and didn't set any session on the server.

some notable features:

- All requests except for login and register, need to put JWT token in headers.
e.g. `Authorization: Bearer #{JWT}`

- A middleware is dedicated to decoding JWT, using the `Warden::JWTAuth::UserDecoder` method.

    - If JWT is valid and decoded successfully, we will get the user record and then save it to environment variables  `@env["api_v1_user"]` to treat as `current_user`  

    - If `current_user` is not find, raise `AuthorizationError` error with 401 status code.

- `UserAuthService` for user authentication method, e.g. register, login, logout
    - `verify` method to verify request JWT

        When the user refreshes the front-end page, the front-end APP will check cookies in the browser to find JWT,  
        if it gets JWT, it will send the request to check if this JWT is still valid or not.

### Error Handling

handle by `ExceptionHandler`, rescue_from errors, and handle 404 not found errors
## Devise + Devise JWT in Grape

use `devise` and `devise_JWT` gems

create a dedicated secret key for devise_JWT:

```ruby
rake secret
# e640f24efc4205caed....xxxx
```

then set to `credentials.yml.enc` by  

`EDITOR=vim rails credentials:edit`  
and input

```yml
devise_JWT_secret_key: e640f24efc4205caed....xxxx
```

in `devise.rb` 

```ruby
config.jwt do |jwt|
  jwt.secret = Rails.application.credentials.devise_jwt_secret_key!
  jwt.expiration_time = 30.minutes.to_i
end
```

All devise sets are done.

### Authentication Strategy

Use [JTIMatcher](https://github.com/waiting-for-dev/devise-JWT/blob/master/lib/devise/JWT/revocation_strategies/jti_matcher.rb) strategy provided by devise-JWT gem:  

The strategy uses `jti` (JWT Token ID), to decode and encode the JWT token.

When getting a JWT from request, devise-jwt use `jti` to decode to check if a token is valid.

Need to add a column `jti` into the `users` table

description of JTIMatcher strategy from devise_JWT wiki:

`To tell whether a token is revoked, it just compares both  'jti' values. On revocation, it changes column value so that the token is no longer valid.`

- add `jti` column in User, and this column should be unique indexed.  
`jti` for encode and decode JWT
- `Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)` will get JWT

- `Warden::JWTAuth::UserDecoder.new.call(token, :user, nil)` to decode JWT then get current user

### revoke token

for logging out a user

```ruby
 def logout
    User.revoke_JWT(nil, User.find(@user_id))
  end
```

this will update `jti` column, making JWT unable to be decoded.

references:

1. [devise and devise_JWT configuration](https://github.com/waiting-for-dev/devise-JWT/wiki/Configuring-devise-for-APIs)
2. [devise_JWT](https://github.com/waiting-for-dev/devise-JWT)
3. [devise_JWT JTIMatcher](https://www.rubydoc.info/gems/devise-JWT/0.2.0/Devise/JWT/RevocationStrategies/JTIMatcher)

## CROS

Front-end and back-end are not the same domain, need to set CROS config

By setting `config/initializers/cors.rb`
allow front-end port 8080 to send request

TODO: this is just for the local environment, production or staging will need further settings

```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "localhost:8080"

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

## Vue configurate

set request base URL by setting the `.env` file

We can add `.env.development` file  

Each env params should start with 'VUE_APP'

For excample, I set 
`VUE_APP_REMOTE_URL=http://localhost:3000`  
 in `.env.development` for axios to send request to localhost



reference: https://cli.vuejs.org/guide/mode-and-env.html#environment-variables
