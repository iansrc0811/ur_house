# Crawer

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
