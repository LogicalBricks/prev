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

ActiveSupport::Inflector.inflections do |inflect|
  remplazos = {
    'a' => 'as',
    'e' => 'es',
    'i' => 'is',
    'o' => 'os',
    'u' => 'us',
    'd' => 'des',
    'j' => 'jes',
    'l' => 'les',
    'n' => 'nes',
    'r' => 'res',
    'y' => 'yes',
    'z' => 'ces',
  }

  inflect.plural(/(z|[aeiou]|[rndljy])(?=$)/, remplazos)


  inflect.singular(/((?<singular>ia)|(?<singular>ta)|(?<singular>[aeiou][rldyjn])es|(?<singular>[bcdfgpt][lr]e|[aeiou])s)(?=$)/, '\\k<singular>')

  # Para singularizar palabras con 'ces', como 'maices'
  inflect.singular(/ces$/, 'z')

  #-----------------------------------------------------------------------------

  # Las palabras en singular que terminan con s son un caso especial, ya que
  # rails infiere que ya están en plural, lo cual es falso. Por ejemplo, pais.
  # Es necesario indicar que el plural de pais es paises y viceversa. Esto se
  # puede hacer declarándolo como irregular:
  inflect.irregular 'pais', 'paises'
  # Pero es necesario agregar otra regla. Pais termina en s, pero ya está en
  # singular, por lo que hay que indicarle a rails que no elimine la s final.
  inflect.singular /(pais)(?=[A-Z]|_|$)/, '\1'

  # el mismo caso aplica para 'mes'
  inflect.irregular 'mes', 'meses'
  inflect.singular /(mes)(?=[A-Z]|_|$)/, '\1'

  # Ejemplos cuyo plural y singular sea el mismo
  inflect.uncountable %w( campus lunes martes miercoles jueves viernes )
end
