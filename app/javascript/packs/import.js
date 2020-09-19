import $ from "jquery";

$(document).ready(function () {
  $("#importForm")
    .on("ajax:success", function (event) {
      let data, status, xhr;
      [data, status, xhr] = event.detail;

      const response = JSON.parse(xhr.responseText);

      const results =
        `Errors: ${response.errors.length}<br/>` +
        `Not Processed: ${response.not_processed.length}<br/>` +
        `Total Albums Imported: ${response.totals.albums}<br/>` +
        `Total Artists Imported: ${response.totals.artists}<br/>` +
        `Total Songs Imported: ${response.totals.songs}<br/>`;

      $("#results").innerHTML = "";
      $("#results").append(results);
    })
    .on("ajax:error", function (event) {
      let data, status, xhr;
      [data, status, xhr] = event.detail;

      $("#results").innerHTML = "";
      $("#results").append(xhr.responseText);
    });
});
