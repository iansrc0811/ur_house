# README

## Version

- Ruby: 3.1.2
- Rails: 7.03
- PostgreSQL

## Setup

this will create DBs then runs seed file.

```ruby
rails db:setup
bundle
```

seed files will create users and fetching residences datas from [urhouse.com](https://www.urhouse.com.tw/), including the image

normal users:  
user@test.com, user2@test.com with password: 123456

admin users:  
admin@test.com, password: `123456
## Reset

this will drops all DB and records, then create DB and runs seed file.
`rails db:reset`

## Instructions

See [Instruction.md](Instruction.md) to get development details
