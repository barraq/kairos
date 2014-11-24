# API

## Get token

    require 'unirest' 
    res = Unirest.post "http://0.0.0.0:3000/api/all/session", parameters: { 'email' => 'SOMEONE@SOMEWHERE.COM', 'password' => 'SOME_PASSWORD' }
    puts 'Private-token is %s', res.body.private_token

## Get all entries

    require 'unirest'
    res = Unirest.get "http://0.0.0.0:3000/api/v1/entries", headers: { 'private_token' => 'PUT_HERE_PRIVATE_TOKEN' }
    puts 'Entries are', res.body 

## 
