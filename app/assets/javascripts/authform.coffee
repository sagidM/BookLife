document.addEventListener "turbolinks:load", ->
  $("#open_auth_form").one("click", ->
    form = document.getElementById("new_user")
    icon = document.getElementById("user_icon_form")
    submit = document.getElementById("signing")
    emailLoadingTimeout = null
    inputLastTime = 0
    registrationFields = document.getElementById("registration_fields")
    emailField = document.getElementById("user_email")
    $(emailField).on('input', ->
      icon.removeAttribute("src")
      clearTimeout(emailLoadingTimeout)
      email = emailField.value
      registrationFields.dataset.action = "sign_in"
      if email.length is 0
        form.dataset.emailValidation = 'empty'
      else if isEmailValid email
        form.dataset.emailValidation = 'loading'
        inputNow = Date.now()
        emailLoadingTimeout = setTimeout(->
          findUserByEmail(email, (user) ->
            if user is null
              form.dataset.emailValidation = 'not_found'
              registrationFields.dataset.action = "sign_up"
              submit.value = submit.dataset.signUp
            else
              form.dataset.emailValidation = 'found'
              submit.value = submit.dataset.signIn
              icon.src = user.image.icon unless user.image.icon is null
          )
        , if inputNow-3000 > inputLastTime then 0 else 200)
        inputLastTime = inputNow
      else
        form.dataset.emailValidation = 'invalid'

    ).trigger('input')
    submit.addEventListener("click", (e) ->
        switch form.dataset.emailValidation
          when "found" then form.action = "/login"
          when "not_found" then form.action = "/register"
          else
            e.preventDefault()
            alert 'put email'
    )
  )

emailRegex = /^[-a-z0-9.]+@[-a-z0-9.]+\.[-a-z0-9]+$/i
isEmailValid = (email) ->
  emailRegex.test email

finding = null
findUserByEmail = (email, callback) ->
  unless finding is null or finding.readyState is XMLHttpRequest.DONE
    finding.abort()
  finding = $.get("/users/find?user[email]=#{encodeURIComponent(email)}", callback)
