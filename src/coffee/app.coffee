class YearlyIncome
  constructor: (@monthlyWage, @funds, @interestRate) ->

  totalIncome: ->
    return @monthlyWage * 12 + @funds * @interestRate

  incomeBySecond: ->
    return @totalIncome() / (3600 * 24 * 365.25)


class Finding
  constructor: (@amount, @distance) ->

  earningsPerSecond: (pickupTime) ->
    return @amount / pickupTime


class Person
  constructor: (@name, @yearlyIncome, @walkingSpeed) ->

  incomeBySecond: ->
    return @yearlyIncome.incomeBySecond()

  pickupTime: (finding) ->
    return (((2 * finding.distance) / @walkingSpeed) + 1)


class Calculation
  constructor: (@person, @finding) ->

  worthPickup: ->
    pickupTime = @person.pickupTime( @finding )
    earningsPerSecond  = @finding.earningsPerSecond( pickupTime )

    # console.log "earningsPerSecond", earningsPerSecond
    # console.log "@person.incomeBySecond", @person.incomeBySecond()

    return earningsPerSecond > @person.incomeBySecond()


class Denomination
  constructor: (@value, @singularLabel, @pluralLabel) ->


class Currency
  constructor: (@name, @symbol, @demoninations, @territory) ->

  demoninationForAmount: (amount) ->
    for d in @demoninations
      if d.value == amount
        return d

    return null

class CurrencyController
  constructor: () ->
    @currencies = {}

    sek_dens = [
      (new Denomination 1, "Enkrona", "Enkronor"),
      (new Denomination 5, "Femma", "Femmor"),
      (new Denomination 10, "Tia", "Tio"),
      (new Denomination 20, "Tjuga", "Tjugor"),
      (new Denomination 50, "Femtilapp", "Femtilappar"),
      (new Denomination 100, "Hundring", "Hundralappar"),
      (new Denomination 500, "Femhundring", "Femhundringar"),
      (new Denomination 1000, "Tusenlapp", "Tusenlappar"),
    ]
    sek = new Currency "Svenska kronor", "kr", sek_dens, "se"

    usd_dens = [

      (new Denomination 0.01, "Penny", "Pennies")
      (new Denomination 0.05, "Nickel", "Nickels")
      (new Denomination 0.1, "Dime", "Dimes")
      (new Denomination 0.25, "Quarter", "Quarters")
      (new Denomination 446.5, "Pre-1965 Silver Quarter", "Pre-1965 Silver Quarters")
      (new Denomination 0.5, "Half dollar", "Half dollars")
      (new Denomination 1, "One", "One's"),
      (new Denomination 2, "Two dollar bill", "Two dollar bills"),
      (new Denomination 5, "Five-spot", "Five-spots"),
      (new Denomination 10, "Tenner", "Tenners"),
      (new Denomination 20, "Twenty", "Twenties"),
      (new Denomination 50, "Fifty", "Fifties"),
      (new Denomination 100, "Hundred", "Hundreds"),
    ]
    usd = new Currency "US dollar", "$", usd_dens, "us"

    @addCurrency sek
    @addCurrency usd

  addCurrency: (@currency) ->
    @currencies[@currency.territory] =  @currency

  currencyForTerritory: (territory) ->
    return @currencies[territory]



$ ->

  cc = new CurrencyController()

  territory = 'us'  # CASH?.locale?.territory ? 'us'
  currency = cc.currencyForTerritory territory

  $('.add-on.currency').text(currency.symbol)
  for d in currency.demoninations
    $('#amount')
      .append($("<option></option>")
      .attr("value", d.value)
      .text(d.singularLabel));

  getInput = () ->

    input = {}

    input.name = $('#name').val() || "Stranger"
    input.amount = parseFloat($('#amount').val(), 10) || 0
    input.distance = parseFloat($('#distance').val(), 10) || 0
    input.walking_speed = parseFloat($('#walking_speed').val(), 10) || 1
    input.monthly_income = parseFloat($('#monthly_income').val(), 10) || 0
    input.funds = parseFloat($('#funds').val(), 10) || 0
    input.interest_rate = parseFloat($('#interest_rate').val() / 100, 10) || 0

    return input

  $('form.cash input, form.cash select').change ->

    input = getInput()

    yearlyIncome = new YearlyIncome input.monthly_income, input.funds, input.interest_rate
    finding = new Finding input.amount, input.distance
    person = new Person input.name, yearlyIncome, input.walking_speed

    calculation = new Calculation person, finding

    result = 'should'
    result += ' NOT' if calculation.worthPickup() isnt true

    d = currency.demoninationForAmount finding.amount
    denomination = d?.pluralLabel?.toLowerCase() ? "" + finding.amount + "'s"

    result = "You " + result + " pickup " + denomination + " from the ground, " + person.name

    $('#result').text(result)

