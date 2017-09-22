$(document).ready(function() {
  $(".project-submit").click(function(event) {
    var title = $("#title").val()
    if (title.length == 0) {
      event.preventDefault()
      $(".project-error").show()
      $(".title").addClass("has-error")
    }
  });

  $(".volunteer-submit").click(function(event) {
    var name = $("#name").val()
    if (name.length == 0) {
      event.preventDefault()
      $(".volunteer-error").show()
      $(".name").addClass("has-error")
    }
  });
});
