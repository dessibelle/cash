(function() {
  var Calculation, Finding, Person, YearlyIncome, calculation, finding, person, result, yearlyIncome;

  YearlyIncome = (function() {
    function YearlyIncome(monthlyWage, funds, interestRate) {
      this.monthlyWage = monthlyWage;
      this.funds = funds;
      this.interestRate = interestRate;
    }

    YearlyIncome.prototype.totalIncome = function() {
      return this.monthlyWage * 12 + this.funds * this.interestRate;
    };

    YearlyIncome.prototype.incomeBySecond = function() {
      return this.totalIncome() / (3600 * 24 * 365.25);
    };

    return YearlyIncome;

  })();

  Finding = (function() {
    function Finding(amount, distance) {
      this.amount = amount;
      this.distance = distance;
    }

    Finding.prototype.earningsPerSecond = function(pickupTime) {
      return this.amount / pickupTime;
    };

    return Finding;

  })();

  Person = (function() {
    function Person(name, yearlyIncome, walkingSpeed) {
      this.name = name;
      this.yearlyIncome = yearlyIncome;
      this.walkingSpeed = walkingSpeed;
    }

    Person.prototype.incomeBySecond = function() {
      return this.yearlyIncome.incomeBySecond();
    };

    Person.prototype.pickupTime = function(finding) {
      return ((2 * finding.distance) / this.walkingSpeed) + 1;
    };

    return Person;

  })();

  Calculation = (function() {
    function Calculation(person, finding) {
      this.person = person;
      this.finding = finding;
    }

    Calculation.prototype.worthPickup = function() {
      var earningsPerSecond, pickupTime;

      pickupTime = this.person.pickupTime(this.finding);
      earningsPerSecond = this.finding.earningsPerSecond(pickupTime);
      console.log("earningsPerSecond", earningsPerSecond);
      console.log("@person.incomeBySecond", this.person.incomeBySecond());
      return earningsPerSecond > this.person.incomeBySecond();
    };

    return Calculation;

  })();

  yearlyIncome = new YearlyIncome(30000, 10000000000, 0.01);

  finding = new Finding(100, 8);

  person = new Person("Simon", yearlyIncome, 1.5);

  calculation = new Calculation(person, finding);

  result = 'should';

  if (calculation.worthPickup() !== true) {
    result += ' NOT';
  }

  console.log("You " + result + " pickup " + finding.amount + "'s from the ground " + person.name);

}).call(this);
