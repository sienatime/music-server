import $ from "jquery";

$(document).ready(() => {
  $("#search-input").keypress(function (e) {
    if (e.which == 13) {
      const url = $(this).data("url");
      search(url, this.value);
      return false;
    }
  });

  $("#search-button").click(function () {
    const url = $(this).data("url");
    const term = $("#search-input").val();
    search(url, term);
  });

  function search(url, term) {
    const params = $.param({ query: term });
    window.location = `${url}?${params}`;
  }
});
