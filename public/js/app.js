$('.close').click(function (evt) {
  evt.preventDefault();

  var $this = $(this);
  $this.parents("div.message").fadeOut(500, function() {
    $(this).remove();
  });
});
