# API

## Get token

    require 'unirest' 
    res = Unirest.post "http://0.0.0.0:3000/api/all/session", parameters: { 'email' => 'SOMEONE@SOMEWHERE.COM', 'password' => 'SOME_PASSWORD' }
    puts 'Private-token is %s', res.body.private_token

## Get all entries

    require 'unirest'
    res = Unirest.get "http://0.0.0.0:3000/api/v1/entries", headers: { 'private_token' => 'PUT_HERE_PRIVATE_TOKEN' }
    puts 'Entries are', res.body 

# BD

1. Login to postgresql prompt as the postgres user

    sudo su postgres -c psql

2. Create a postgresql user for your project

    create user `username` with password `'password'`;

3. Setup your postgres user and make him a postgres superuser

    alter user `username` superuser;

4. Create the development and test databases

    create database kairos_development;
    create database kairos_test;

5. Give permissions to the user on the databases

    grant all `privileges` on database kairos_development to `username`;
    grant all `privileges` on database kairos_test to `username`;

To end the postgresql session type \q

Update password for the user

    alter user `username` with password `'password'`;
