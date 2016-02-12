module ApplicationHelper
  def mark_for value
    value ? check_mark : cross_mark
  end

  def check_mark
    content_tag :i, '', class: 'fa fa-check text-success'
  end

  def cross_mark
    content_tag :i, '', class: 'fa fa-times text-danger'
  end

  def ccs_class_for_payable(model)
    model.to_be_paid? ? "danger" : "success"
  end
end
