/*
 * This file provides the form for Test's title editing.
 */
document.addEventListener('turbolinks:load', function() {
  $('.form-inline-link').on('click', formInLineLinkHandler);

  var errors = $('.resource-errors');

  if (errors) {
    // var resourceId = errors.dataset.resourceId;
    var resourceId = errors.data("resourceId");

    formInLineHandler(resourceId);
  }
});

function formInLineLinkHandler(event) {
  // don't go to 'Edit Test' form
  event.preventDefault();
  // when click 'edit' (_test partial) object in memory (this) has 'data: {...}' attr.,
  // 'dataset' is a method to extract it
  var testId = this.dataset.testId;
  // console.log(testId);
  formInLineHandler(testId);
}

function formInLineHandler(testId) {
  var $link = $('.form-inline-link[data-test-id="' + testId + '"]');
  var $testTitle = $('.test-title[data-test-id="' + testId + '"]').val();
  var $formInLine = $('.form-inline[data-test-id="' + testId + '"]');

  // toggles form_inline
  $formInLine.toggle();
  if (typeof $testTitle !== 'undefined' && $testTitle.length) $testTitle.toggle();

  if ($formInLine.is(':visible')) {
    $link.text('Cancel');
  }
  else {
    $link.text('Edit');
  }
}
