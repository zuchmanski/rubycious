# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  char_counter = ->
    form = $('form#new_article')
    limit = 160
    span_limit = $('#char-counter', form)

    form.keydown ->
      count = $('.body textarea', form).val().length
      span_limit.html(count)

  toggle_date_and_author = ->
    $('li.article').hover(
      -> ($('.meta', $(this)).show())
      -> ($('.meta', $(this)).hide())
    )

  char_counter()
  toggle_date_and_author();