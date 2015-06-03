<head>
<link rel="stylesheet" type="text/css" href="pure-min.css" media="all">
</head>

<body>
<form class="pure-form">
    <fieldset>
        <legend>A compact inline form</legend>

        <input type="email" placeholder="Email">
        <input type="password" placeholder="Password">

        <label for="remember">
            <input id="remember" type="checkbox"> Remember me
        </label>

        <button type="submit" class="pure-button pure-button-primary">Sign in</button>
    </fieldset>
</form>

<hr/>

<form class="pure-form pure-form-stacked">
    <fieldset>
        <legend>A Stacked Form</legend>

        <label for="email">Email</label>
        <input id="email" type="email" placeholder="Email">

        <label for="password">Password</label>
        <input id="password" type="password" placeholder="Password">

        <label for="state">State</label>
        <select id="state">
            <option>AL</option>
            <option>CA</option>
            <option>IL</option>
        </select>

        <label for="remember" class="pure-checkbox">
            <input id="remember" type="checkbox"> Remember me
        </label>

        <button type="submit" class="pure-button pure-button-primary">Sign in</button>
    </fieldset>
</form>

<hr>

<form class="pure-form pure-form-aligned">
    <fieldset>
        <div class="pure-control-group">
            <label for="name">Username</label>
            <input id="name" type="text" placeholder="Username">
        </div>

        <div class="pure-control-group">
            <label for="password">Password</label>
            <input id="password" type="password" placeholder="Password">
        </div>

        <div class="pure-control-group">
            <label for="email">Email Address</label>
            <input id="email" type="email" placeholder="Email Address">
        </div>

        <div class="pure-control-group">
            <label for="foo">Supercalifragilistic Label</label>
            <input id="foo" type="text" placeholder="Enter something here...">
        </div>

        <div class="pure-controls">
            <label for="cb" class="pure-checkbox">
                <input id="cb" type="checkbox"> I've read the terms and conditions
            </label>

            <button type="submit" class="pure-button pure-button-primary">Submit</button>
        </div>
    </fieldset>
</form>

</body>