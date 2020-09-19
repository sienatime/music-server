import $ from "jquery";

$(document).ready(() => {
  $("#selectAll").change(function () {
    $(".checkbox-song").prop("checked", this.checked);
  });

  $("#downloadButton").click(() => {
    const url = $("#downloadButton").data("url");
    const song_ids = $(".checkbox-song:checked")
      .map(function () {
        return this.id;
      })
      .get();

    const params = $.param({ ids: song_ids });

    window.location = `${url}?${params}`;
  });
});
