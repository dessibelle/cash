(function() {
  var Calculation, Currency, CurrencyController, Denomination, Finding, Person, YearlyIncome;

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
      return earningsPerSecond > this.person.incomeBySecond();
    };

    return Calculation;

  })();

  Denomination = (function() {
    function Denomination(value, singularLabel, pluralLabel) {
      this.value = value;
      this.singularLabel = singularLabel;
      this.pluralLabel = pluralLabel;
    }

    return Denomination;

  })();

  Currency = (function() {
    function Currency(name, symbol, demoninations, territory) {
      this.name = name;
      this.symbol = symbol;
      this.demoninations = demoninations;
      this.territory = territory;
    }

    Currency.prototype.demoninationForAmount = function(amount) {
      var d, _i, _len, _ref;

      _ref = this.demoninations;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        d = _ref[_i];
        if (d.value === amount) {
          return d;
        }
      }
      return null;
    };

    return Currency;

  })();

  CurrencyController = (function() {
    function CurrencyController() {
      var sek, sek_dens, usd, usd_dens;

      this.currencies = {};
      sek_dens = [new Denomination(1, "Enkrona", "Enkronor"), new Denomination(5, "Femma", "Femmor"), new Denomination(10, "Tia", "Tio"), new Denomination(20, "Tjuga", "Tjugor"), new Denomination(50, "Femtilapp", "Femtilappar"), new Denomination(100, "Hundring", "Hundralappar"), new Denomination(500, "Femhundring", "Femhundringar"), new Denomination(1000, "Tusenlapp", "Tusenlappar")];
      sek = new Currency("Svenska kronor", "kr", sek_dens, "se");
      usd_dens = [new Denomination(0.01, "Penny", "Pennies"), new Denomination(0.05, "Nickel", "Nickels"), new Denomination(0.1, "Dime", "Dimes"), new Denomination(0.25, "Quarter", "Quarters"), new Denomination(446.5, "Pre-1965 Silver Quarter", "Pre-1965 Silver Quarters"), new Denomination(0.5, "Half dollar", "Half dollars"), new Denomination(1, "One", "One's"), new Denomination(2, "Two dollar bill", "Two dollar bills"), new Denomination(5, "Five-spot", "Five-spots"), new Denomination(10, "Tenner", "Tenners"), new Denomination(20, "Twenty", "Twenties"), new Denomination(50, "Fifty", "Fifties"), new Denomination(100, "Hundred", "Hundreds")];
      usd = new Currency("US dollar", "$", usd_dens, "us");
      this.addCurrency(sek);
      this.addCurrency(usd);
    }

    CurrencyController.prototype.addCurrency = function(currency) {
      this.currency = currency;
      return this.currencies[this.currency.territory] = this.currency;
    };

    CurrencyController.prototype.currencyForTerritory = function(territory) {
      return this.currencies[territory];
    };

    return CurrencyController;

  })();

  $(function() {
    var cc, currency, d, getInput, territory, _i, _len, _ref;

    cc = new CurrencyController();
    territory = 'us';
    currency = cc.currencyForTerritory(territory);
    $('.add-on.currency').text(currency.symbol);
    _ref = currency.demoninations;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      d = _ref[_i];
      $('#amount').append($("<option></option>").attr("value", d.value).text(d.singularLabel));
    }
    getInput = function() {
      var input;

      input = {};
      input.name = $('#name').val() || "Stranger";
      input.amount = parseFloat($('#amount').val(), 10) ||  0;
      input.distance = parseFloat($('#distance').val(), 10) ||  0;
      input.walking_speed = parseFloat($('#walking_speed').val(), 10) ||  1;
      input.monthly_income = parseFloat($('#monthly_income').val(), 10) ||  0;
      input.funds = parseFloat($('#funds').val(), 10) ||  0;
      input.interest_rate = parseFloat($('#interest_rate').val() / 100, 10) ||  0;
      return input;
    };
    return $('form.cash input, form.cash select').change(function() {
      var calculation, denomination, finding, input, person, result, yearlyIncome, _ref1, _ref2;

      input = getInput();
      yearlyIncome = new YearlyIncome(input.monthly_income, input.funds, input.interest_rate);
      finding = new Finding(input.amount, input.distance);
      person = new Person(input.name, yearlyIncome, input.walking_speed);
      calculation = new Calculation(person, finding);
      result = 'should';
      if (calculation.worthPickup() !== true) {
        result += ' NOT';
      }
      d = currency.demoninationForAmount(finding.amount);
      denomination = (_ref1 = d != null ? (_ref2 = d.pluralLabel) != null ? _ref2.toLowerCase() : void 0 : void 0) != null ? _ref1 : "" + finding.amount + "'s";
      result = "You " + result + " pickup " + denomination + " from the ground, " + person.name;
      return $('#result').text(result);
    });
  });

}).call(this);
