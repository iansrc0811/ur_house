# README

## Version

- Ruby: 3.1.2
- Rails: 7.03
- PostgreSQL

## Setup

this will create DBs then runs seed file.
`rails db:setup`
seed files will create users, fetching residences datas from [urhouse.com](https://www.urhouse.com.tw/), including the image

## Reset

this will drops all DB and records, then create DB and runs seed file.
`rails db:reset`

## Instructions

See [Instruction.md](instruction.md) to get development details
