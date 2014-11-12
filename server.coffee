express = require 'express'
path = require 'path'
app = express()
http = require 'http'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/test'
User = require './app/models/user'

PORT = process.env.PORT or 8089

app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()

app.get '/', (request, response) ->
  response.sendFile(__dirname + '/public/login/html/login.html')

app.use(express.static(path.join(__dirname, 'public'))) 

router = express.Router()

router.use (request, response, next) ->
  console.log 'Something Happened'
  next()

router.route '/deleteAll'
  .delete (request, response) ->
    User.remove {}, ->
      console.log 'All Users Deleted'
      response.json message:'All Users Deleted'

router.route('/')
  .get (request, response) ->
    console.log 'Get Happened'
    User.find (err, users) ->
      if err
        response.send err
      response.json users
      #response.json {pokemon:'Porygon'}

  .post (request, response) ->
    console.log 'Post Happened'
    switch request.body.submissionType
      when 'register'
        User.findOne {username:request.body.user.username}, (error, user) ->
          if error
            console.log 'ERROR', error
          else
            if user isnt null
              response.json {message: 'USERNAME TAKEN'}
              console.log 'User creation attempted, but username already exists'
            else
              newUser = new User()
              newUser.username = request.body.user.username
              newUser.password = request.body.user.password
              newUser.numberOfLogins = 0
              console.log 'Request Body', request.body
              newUser.save (error) ->
                if error
                  response.send error
                response.json message:'USER CREATED'
                console.log 'User Created'
      when 'login'
        User.findOne {username:request.body.user.username}, (error, user) ->
          if error
            console.log 'ERROR', error
          else
            if user isnt null
              passwordAttempted = request.body.user.password
              actualPassword = user.password
              if passwordAttempted is actualPassword
                response.json message:'PASSWORD ACCEPTED'
                user.numberOfLogins++
                user.save (error) ->
                  if error
                    response.send error
                    console.log 'Error in saving user'
                  else
                    console.log 'User data saved'
              else
                response.json message:'DID NOT WORK'
                console.log 'Login attempted, but password was not correct'
            else
              response.json {message: 'DID NOT WORK'}
              console.log 'Login attempted, but username does not exist'

router.route('/:user_id')
  .get (request, response) ->
    User.findById request.params.user_id, (error, user) ->
      if error
        response.send error
      response.json user

app.use '/user', router

httpServer = http.createServer app

httpServer.listen PORT, ->
  console.log 'Server running on ' + PORT