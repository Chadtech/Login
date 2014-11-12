$('#loginSubmit').click (event) ->
  usernameToSubmit = $('#loginUsername').val()
  passwordToSubmit = $('#loginPassword').val()
  user =
    username: usernameToSubmit
    password: passwordToSubmit
  submission =
    user:user
    submissionType: 'login'
  $.post 'http://localhost:8089/user', submission, (data) ->
    switch data.message
      when 'DID NOT WORK'
        $('#loginUsername').addClass 'problem'
        $('#loginUsername').val ' '
        $('#loginPassword').addClass 'problem'
        $('#loginPassword').val ''
        $('#loginPassword').attr 'placeholder', ' '
        setTimeout ->
          $('#loginUsername').removeClass 'problem'
          $('#loginPassword').removeClass 'problem'
          $('#loginUsername').val ''
          $('#loginPassword').val ''
          $('#loginPassword').attr 'placeholder', 'password'
        , 2000
      when 'PASSWORD ACCEPTED'
        $('#loginUsername').addClass 'success'
        $('#loginUsername').val 'success'
        $('#loginPassword').addClass 'success'
        $('#loginPassword').attr 'placeholder', ''
        $('#loginPassword').val ''

$('#registerSubmit').click (event) ->
  usernameToSubmit = $('#registerUsername').val()
  passwordToSubmit = $('#registerPassword').val()
  newUser = 
    username: usernameToSubmit
    password: passwordToSubmit
  submission =
    user: newUser
    submissionType: 'register'
  $.post 'http://localhost:8089/user', submission, (data) ->
    switch data.message
      when 'USERNAME TAKEN'
        $('#registerUsername').addClass 'problem'
        $('#registerUsername').attr 'placeholder', 'already taken'
        $('#registerUsername').val '' 
        setTimeout ->
          $('#registerUsername').removeClass 'problem'
          $('#registerUsername').attr 'placeholder', 'username'
        , 2000
      when 'USER CREATED'
        $('#registerUsername').addClass 'success' 
        $('#registerUsername').val 'user created'

        $('#registerPassword').addClass 'success'
        $('#registerPassword').attr 'placeholder', ''
        $('#registerPassword').val ''


