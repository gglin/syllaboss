$(function() {
  $("a.mark-all-read").click(function() {
    // alert("Clicked!");
    $.post("/announcements/markallread", function(data) {
      alert("All announcements for today have been marked as read.");
    });
    // $(this).closest('.slide-box').hide();
    $(this).hide();
    $(this).closest('.slide-content').hide();
  });
});