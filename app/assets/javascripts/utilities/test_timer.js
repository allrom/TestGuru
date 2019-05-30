/*
 * This file provides the form for Test's timing.
 */
document.addEventListener('turbolinks:load', function() {
  var $timer = $('.exam_timer');
  var $timer_header = $('.exam_timer_header');

  if ($timer && $timer.data("timer")) {
    examTimer($timer, $timer_header);
  }
});

function examTimer(timer, header) {
  if (timer.data("completed")) {
    timer.countdown('destroy');
    header.toggle();
    return false;
  }
  var testSeconds = timer.data("seconds");
  var expiryUrl = timer.data("redirectExpire");
  header.show();

  timer.countdown({
    until: +testSeconds,
    format: 'HMS',
    padZeroes: true,
    expiryUrl: expiryUrl,
    onExpiry: timeExpired
  });
}

function timeExpired() {
  alert('Test time expired...');
}
