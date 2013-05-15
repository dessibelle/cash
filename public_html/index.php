<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Worth Pickup?</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

    <link rel="stylesheet" href="css/main.min.css">
    <script src="js/modernizr-2.6.2.min.js"></script>
  </head>
  <body>
    <!--[if lt IE 7]>
      <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
    <![endif]-->


    <div class="container">
      <div class="row-fluid">

        <header class="page-title">
          <h1>Picking up cash from the ground</h1>
        </header>

        <form class="form-horizontal cash">

          <fieldset>
            <legend>About you</legend>
            <div class="control-group">
              <label class="control-label" for="name">Your name</label>
              <div class="controls">
                <input type="text" id="name" placeholder="Your name">
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="walking_speed">Walking speed</label>
              <div class="controls">

                <div class="input-append">
                  <input type="text" id="walking_speed" placeholder="Walking speed">
                  <span class="add-on speed">m/s</span>
                </div>

              </div>
            </div>
          </fieldset>


          <fieldset>
            <legend>You stumple upon</legend>
            <div class="control-group">
              <label class="control-label" for="amount">Denomination</label>
              <div class="controls">
                <select id="amount">

                </select>
              </div>
            </div>


            <div class="control-group">
              <label class="control-label" for="distance">Distance</label>
              <div class="controls">

                <div class="input-append">
                  <input type="text" id="distance" placeholder="Distance">
                  <span class="add-on distance">m</span>
                </div>

              </div>
            </div>
          </fieldset>


          <fieldset>
            <legend>Your financial situation</legend>
            <div class="control-group">
              <label class="control-label" for="monthly_income">Monthly income</label>
              <div class="controls">

                <div class="input-append">
                  <input type="text" id="monthly_income" placeholder="Monthly income">
                  <span class="add-on currency"></span>
                </div>

              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="funds">Funds</label>
              <div class="controls">

                <div class="input-append">
                  <input type="text" id="funds" placeholder="Funds">
                  <span class="add-on currency"></span>
                </div>

              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="interest_rate">Interest rate</label>
              <div class="controls">

                <div class="input-append">
                  <input type="text" id="interest_rate" placeholder="Interest rate">
                  <span class="add-on interest-rate">%</span>
                </div>

              </div>
            </div>
          </fieldset>

        </form>

        <p id="result"></p>

      </div>
    </div>

    <script>
      <?php
        $al = $_SERVER['HTTP_ACCEPT_LANGUAGE'];
        $locale = $territory = null;

        $parts = explode("-", $al);
        if (count($parts)) {
          $locale = $parts[0];
          $territory = $parts[1];
        }

        $locale_data = array(
          'acceptLanguage' => $al,
          'locale' => $locale,
          'territory' => $territory,
        );
      ?>

      var CASH = {};
      CASH.locale = <?php echo json_encode( $locale_data ); ?>;

    </script>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/jquery-1.9.1.min.js"><\/script>')</script>

    <script src="js/app.js"></script>

    <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
    <script>
      var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
      (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
      g.src='//www.google-analytics.com/ga.js';
      s.parentNode.insertBefore(g,s)}(document,'script'));
    </script>
  </body>
</html>
