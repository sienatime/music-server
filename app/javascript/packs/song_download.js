import $ from "jquery";

$(document).ready(() => {
  $("#selectAll").change(function () {
    $(".checkbox-song").prop("checked", this.checked);

    $(".checkbox-song").each(function () {
      toggleRowSelected(this);
    });
  });

  $(".checkbox-song").click(function (event) {
    // don't let clicks bubble up to the row, since that has its own click handler
    // that we don't want to trigger (since it changes the checkbox state)
    event.stopPropagation();
  });

  $(".checkbox-song").change(function () {
    toggleRowSelected(this);
  });

  $(".song-row").click(function () {
    const checkbox = $(this).find(".checkbox-song");
    checkbox.prop("checked", !checkbox.prop("checked"));
    toggleRowSelected(checkbox);
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

function toggleRowSelected(element) {
  if ($(element).prop("checked")) {
    $(element).parents("tr").addClass("tr-selected");
  } else {
    $(element).parents("tr").removeClass("tr-selected");
  }
}
