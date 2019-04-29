/*
 * This file draws the progress bar on test passage.
 */
let progressBar = 0;
document.addEventListener('turbolinks:load', function() {

  if (document.readyState !== 'loading') setProgress();
  else {
    document.attachEvent('onreadystatechange', function() {
    if (document.readyState === 'complete') setProgress();;
    });
  }
});

 if (progressBar) window.onebeforeunload = dropProgress();

function setProgress() {
  var progress = document.querySelector('.test-progress');
  progressBar = document.getElementById("progressBar");

  if (progress) {
    var total = progress.dataset.questionsCount;
    var step = progress.dataset.questionNum;
  }
  var percentg = 100 / total * (step - 1);
  var width = percentg.toFixed(2);

  if (progressBar) progressBar.setAttribute("value", width);
}

function dropProgress() {
  progressBar.setAttribute("value", "0");
}
