# Instructions

Here are some instructions explain how I develped this project

## Crawer

UrHouseCrawer have limited option, it's strict to condition:  

```text
city: "taipei" or "new taipei"，
Type: 住宅(residential)，
Rent:NTD 30000 - 100000, 
sort from low to hight`
```

and the only conditions for params is city and page

```ruby
UrHouseCrawer.new(city: 'new taipei', page: 2)
```

Duo to development time limit, I hardcode the request URL in codebase.
The request url is call after submit the filter form.
I got it from chrome consle directly.

The better solution might be to implement a real

## Devise with JWT
use `devise` and `devise_jwt` gems

create dedicated secret key for devise_jwt:

```ruby
rake secret
# e640f24efc4205caed....xxxx
```

then set to `credentials.yml.enc` by  

`EDITOR=vim rails credentials:edit`  
and input

```yml
devise_jwt_secret_key: e640f24efc4205caed....xxxx
```

### Use `JTIMatcher` strategy to revoke JWT tokens

Need to add a column `jti`(stands for JWT ID) into `users` table

description about JTIMatcher strategy from devise_jwt wiki:

`In order to tell whether a token is revoked, it just compares both  'jti' values. On revocation, it changes column value so that the token is no longer valid.`

references:

1. [devise and devise_jwt configuration](https://github.com/waiting-for-dev/devise-jwt/wiki/Configuring-devise-for-APIs)
2. [devise_jwt](https://github.com/waiting-for-dev/devise-jwt)
2. [devise_jwt JTIMatcher](https://www.rubydoc.info/gems/devise-jwt/0.2.0/Devise/JWT/RevocationStrategies/JTIMatcher)
2. [toturial](https://github.com/DakotaLMartinez/rails-devise-jwt-tutorial)
