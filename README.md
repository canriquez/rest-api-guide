# Rails REST API Simple TDD practice

Small TDD driven practice app to build a Rails RESTful API.
- Contains API controller for : users
- Includes full rspec test for basic API CURD
- No authentication features included so far (I plan to have them at a later stage)
- Intended to be a simple boilerplate for future applications

## Technologies used

* Rails 6.0.3.3
* Ruby: 2.6.5
* Postgresql: 1.2.3
* Factory Bot Rails 

## Database Requirements
- The application runs in a development environment with a Postgresql DB
- Please install pg DB, and create a user/pass for development account.
- app user pre-configured: ``` devuser ```
- It is highly recommended to store you password in an environment variable at login. In a development environment, I use the same password for all my apps. In my case, I have a macOS environment, and I use this command to load the password in the ``` .bash_profile ```

```
echo 'export APPNAME_DATABASE_PASSWORD="PostgreSQL_Role_Password"' >> ~/.bash_profile

```

mode details on how to install and configure your pg database for macOS environments: [How To Use PostgreSQL with Your Ruby on Rails Application on macOS](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-macos)

- Configurations must be hosted @ ``` /config/database.yml ``` 

#### /config/database.yml

``` 

  username: devuser
  password: <%= ENV['APPNAME_DATABASE_PASSWORD'] %>

```



### Bundle Installation 
- Clone Repository
- Run ``` bundle install ```

### Database creation

``` rails db:create  ```

### Database initialization

``` rails db:migrate ```

### How to run the test suite at project root folder.

``` /rspec ```




## Authors

👤 ***Carlos Anriquez***

- Github: [@canriquez](https://github.com/canriquez)
- Twitter: [@cranriquez](https://twitter.com/cranriquez)
- Linkedin: [linkedin](https://www.linkedin.com/in/carlosanriquez/)
- Portfolio: [carlosanriquez.com](https://www.carlosanriquez.com)


## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- For this project, I followed guidance from these awesome articles:
- [Creating a REST API with Rails](https://medium.com/@oliver.seq/creating-a-rest-api-with-rails-2a07f548e5dc)
- [Simple Rails API Server using Simple TDD](https://medium.com/binar-academy/simple-rails-api-server-using-simple-tdd-1a3dbeb3353a)
- [How To Use PostgreSQL with Your Ruby on Rails Application on macOS](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-macos)


## 📝 License

This project is [MIT](lic.url) licensed.
