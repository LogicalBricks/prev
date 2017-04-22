# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.plural(/(a)(?=$)/, 'as')
  inflect.plural(/(e)(?=$)/, 'es')
  inflect.plural(/(i)(?=$)/, 'is')
  inflect.plural(/(o)(?=$)/, 'os')
  inflect.plural(/(u)(?=$)/, 'us')
  inflect.plural(/(d)(?=$)/, 'des')
  inflect.plural(/(j)(?=$)/, 'jes')
  inflect.plural(/(l)(?=$)/, 'les')
  inflect.plural(/(n)(?=$)/, 'nes')
  inflect.plural(/(r)(?=$)/, 'res')
  inflect.plural(/(y)(?=$)/, 'yes')
  inflect.plural(/(z)(?=$)/, 'ces')


  inflect.singular(/((?<singular>ia)|(?<singular>ta)|(?<singular>[aeiou][rldyjn])es|(?<singular>[bcdfgpt][lr]e|[aeiou])s)(?=$)/, '\\k<singular>')
end
