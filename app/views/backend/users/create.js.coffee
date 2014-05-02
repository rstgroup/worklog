$("#users_wrapper").html("<%= escape_javascript(render(UserDecorator.decorate_collection(current_user.account.users))) %>")
$("#users_wrapper").find('.row-fluid.hoverable').each () ->
  bt = $(this).find(".span2 .btn-group")
  bt.hide()
  $(this).hover(
    () -> bt.show(),
    () -> bt.hide())
