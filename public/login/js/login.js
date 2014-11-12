(function() {
  $('#loginSubmit').click(function(event) {
    var passwordToSubmit, submission, user, usernameToSubmit;
    usernameToSubmit = $('#loginUsername').val();
    passwordToSubmit = $('#loginPassword').val();
    user = {
      username: usernameToSubmit,
      password: passwordToSubmit
    };
    submission = {
      user: user,
      submissionType: 'login'
    };
    return $.post('http://localhost:8089/user', submission, function(data) {
      switch (data.message) {
        case 'DID NOT WORK':
          $('#loginUsername').addClass('problem');
          $('#loginUsername').val(' ');
          $('#loginPassword').addClass('problem');
          $('#loginPassword').val('');
          $('#loginPassword').attr('placeholder', ' ');
          return setTimeout(function() {
            $('#loginUsername').removeClass('problem');
            $('#loginPassword').removeClass('problem');
            $('#loginUsername').val('');
            $('#loginPassword').val('');
            return $('#loginPassword').attr('placeholder', 'password');
          }, 2000);
        case 'PASSWORD ACCEPTED':
          $('#loginUsername').addClass('success');
          $('#loginUsername').val('success');
          $('#loginPassword').addClass('success');
          $('#loginPassword').attr('placeholder', '');
          return $('#loginPassword').val('');
      }
    });
  });

  $('#registerSubmit').click(function(event) {
    var newUser, passwordToSubmit, submission, usernameToSubmit;
    usernameToSubmit = $('#registerUsername').val();
    passwordToSubmit = $('#registerPassword').val();
    newUser = {
      username: usernameToSubmit,
      password: passwordToSubmit
    };
    submission = {
      user: newUser,
      submissionType: 'register'
    };
    return $.post('http://localhost:8089/user', submission, function(data) {
      switch (data.message) {
        case 'USERNAME TAKEN':
          $('#registerUsername').addClass('problem');
          $('#registerUsername').attr('placeholder', 'already taken');
          $('#registerUsername').val('');
          return setTimeout(function() {
            $('#registerUsername').removeClass('problem');
            return $('#registerUsername').attr('placeholder', 'username');
          }, 2000);
        case 'USER CREATED':
          $('#registerUsername').addClass('success');
          $('#registerUsername').val('user created');
          $('#registerPassword').addClass('success');
          $('#registerPassword').attr('placeholder', '');
          return $('#registerPassword').val('');
      }
    });
  });

}).call(this);
