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

        console.log "earningsPerSecond", earningsPerSecond
        console.log "@person.incomeBySecond", @person.incomeBySecond()

        return earningsPerSecond > @person.incomeBySecond()

yearlyIncome = new YearlyIncome 30000, 10000000000, 0.01
finding = new Finding 100, 8
person = new Person "Simon", yearlyIncome, 1.5

calculation = new Calculation person, finding

result = 'should'
result += ' NOT' if calculation.worthPickup() isnt true


console.log "You " + result + " pickup " + finding.amount + "'s from the ground " + person.name
