$(document).ready(function() {
  $(".project-info").click(function(event) {
    var title = $("#title").val()
    if (title.length == 0) {
      event.preventDefault()
      $(".alert").show()
      $(".title").addClass("has-error")
    }
  });
});
