/*
 * This file draws the progress bar on test passage.
 */
let progressbar = 0;
document.addEventListener('turbolinks:load', function() {

  if (document.readyState !== 'loading') setProgress();
  else {
    document.attachEvent('onreadystatechange', function() {
    if (document.readyState === 'complete') setProgress();;
    });
  }
});

 if (progressbar) window.onebeforeunload = dropProgress();

function setProgress() {
  var progress = document.querySelector('.test-progress');
  progressbar = document.getElementById("progressBar");

  if (progress) {
    var total = progress.dataset.questionsCount;
    var step = progress.dataset.questionNum;
  }
  var percentg = 100 / total * (step - 1);
  var width = percentg.toFixed(2);

  if (progressbar) progressbar.setAttribute("value", width);
}

function dropProgress() {
  progressbar.setAttribute("value", "0");
}
