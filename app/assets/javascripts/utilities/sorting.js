/*
 * This file provides sorting in Tests table by its "Title" field.
 */
document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.sort-by-title');

  if (control) control.addEventListener('click', sortTRowsByTitle);
});

function sortTRowsByTitle() {
  // table that is being displayed in browser
  var table = document.querySelector('table');

  // "rows" is a "colection" element of type "NodeList"
  // https://developer.mozilla.org/ru/docs/Web/API/NodeList
  var rows = table.querySelectorAll('tr');
  var sortedTRows = [];

  // select all table rows with the exception of "header", i.e. start from "1"
  for (var i = 1; i < rows.length; i++) {
    sortedTRows.push(rows[i]);
  }

  if (this.querySelector('.octicon-arrow-up').classList.contains('hide')) {
    sortedTRows.sort(compareRowsDesc);
    this.querySelector('.octicon-arrow-up').classList.remove('hide');
    this.querySelector('.octicon-arrow-down').classList.add('hide');
  }
  else {
    sortedTRows.sort(compareRowsAsc);
    this.querySelector('.octicon-arrow-down').classList.remove('hide');
    this.querySelector('.octicon-arrow-up').classList.add('hide');
  }

  // placeholder in RAM to temp. store sorted data
  var sortedTable = document.createElement('table');

  // turn "placeholder table" to our original table:
  // assign same class as in original
  sortedTable.classList.add("table", "table-condensed", "table-striped");

  // create <tbody> inside <table>
  var sortedTableBody = document.createElement('tbody');

  //  stick a "header" row
  sortedTableBody.appendChild(rows[0]);

  //  place in sorted rows
  for (var i = 0; i < sortedTRows.length; i++) {
    sortedTableBody.appendChild(sortedTRows[i]);
  }

  // put <tbody> in the <table>
  sortedTable.appendChild(sortedTableBody);

  // replace original table with "constructed in RAM" table
  table.parentNode.replaceChild(sortedTable, table);
}

function compareRowsAsc(row1, row2) {
  var testTitle1 = row1.querySelector('td').textContent;
  var testTitle2 = row2.querySelector('td').textContent;

  if (testTitle1 < testTitle2) return -1;
  if (testTitle1 > testTitle2) return 1;
  return 0;
}

function compareRowsDesc(row1, row2) {
  var testTitle1 = row1.querySelector('td').textContent;
  var testTitle2 = row2.querySelector('td').textContent;

  if (testTitle1 < testTitle2) return 1;
  if (testTitle1 > testTitle2) return -1;
  return 0;
}
