# app/helpers/application_helper.rb
module ApplicationHelper
  def category_emoji(category)
    case category.downcase
    when 'coffee collection' then '◦'
    when 'spring has sprung collection' then '❋'
    when 'dessert collection' then '◉'
    else '◦'
    end
  end
  
  def flash_class(type)
    case type.to_sym
    when :notice
      'bg-green-50 border border-green-200 text-green-800'
    when :alert
      'bg-red-50 border border-red-200 text-red-800'
    when :error
      'bg-red-50 border border-red-200 text-red-800'
    else
      'bg-nude-50 border border-nude-200 text-brown-800'
    end
  end
end