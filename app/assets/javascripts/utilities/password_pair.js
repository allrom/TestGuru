/*
 * This file compares two password fields for matching.
 */
document.addEventListener('turbolinks:load', function() {
  var controls = [];
  var controlConf = document.querySelector('.confirmed-user-password');
  var controlNew = document.querySelector('.created-user-password');

  if (controlConf && controlNew) {
    controls.push('controlConf', 'controlNew');
    controls.forEach(function(control) {
      addEventListener('input', comparePasswdFields);
    });
  }
});

function comparePasswdFields() {
  // collect data
  var passwordVal = document.getElementById("user_password").value;
  var passwordConfirmedVal = document.getElementById("user_password_confirmation").value;

  // call function to hide icon when clear both fields
  if (passwordConfirmedVal == '' && passwordVal == '') iconsHide();
  // call function to show red/green icon
  if (passwordConfirmedVal) iconToggler(passwordVal, passwordConfirmedVal);
}

function iconToggler (val1, val2) {
  var controlIcon = document.querySelector('.octicon-shield');
  // console.log(controlIcon);

  if (val1 !== val2) {
    controlIcon.classList.remove('hide', 'match');
    controlIcon.classList.add('mismatch');
  }
  else {
    controlIcon.classList.remove('hide', 'mismatch');
    controlIcon.classList.add('match');
  }
}

function iconsHide() {
  document.querySelector('.octicon-shield').classList.add('hide');
}
