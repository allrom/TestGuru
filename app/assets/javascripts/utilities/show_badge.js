/*
 * This file toggles badge image for veiwing.
 */
document.addEventListener('turbolinks:load', function() {
  var controls = document.getElementsByClassName('see-badge-image');

  if (controls.length !==0) {
    for (var i = 0; i < controls.length; i++) {
      if (controls[i].dataset.count) {
        controls[i].addEventListener('click', showBadgeImage);
      }
      else {
        preventBadgeImage.call(controls[i]);
      }
    }
  }
});

function showBadgeImage() {
  this.querySelector('.octicon-eye').classList.toggle('hide');
  this.querySelector('.badge-image-file').classList.toggle('hide');
}

function preventBadgeImage() {
  this.querySelector('.octicon-eye').classList.toggle('hide');
  this.querySelector('.octicon-eye-closed').classList.toggle('hide');
}
