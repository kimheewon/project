<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Login Admin</title>

    <!-- Bootstrap -->
    <link href="/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="/vendors/animate.css/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="/build/css/custom.min.css" rel="stylesheet">
  </head>
 <body class="login">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form method="POST" action="/loginAdmin/login">
              <h1 style="color: #2c3e50; font-weight: bold;">관리자 로그인</h1>
              <br><br>
              <div>
                <input value="master" type="text" name="AdminId" class="form-control" placeholder="Admin ID" required="required" style="font-size: 18px;padding: 18px;" autofocus="autofocus"/>
              </div>
              <div>
                <input value="qqqQQQ1!" type="password" name="Password" class="form-control" placeholder="Password" style="font-size:18px;padding: 18px;" required="required" />
              </div>
              <br>
              <br>
              <div>
                <button class="btn btn-default submit" type="submit" style=" background-color:#2c3e50; color:white; border: #2c3e50;">로그인</button>
                
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i>&nbsp;PayLetter</h1>
                  <p>Copyright &copy; HeewonKim 2018</p>
                </div>
              </div>
            </form>
          </section>
        </div>

        <div id="register" class="animate form registration_form">
          <section class="login_content">
            <form>
              <h1>Create Account</h1>
              <div>
                <input type="text" class="form-control" placeholder="Username" required="required" />
              </div>
              <div>
                <input type="email" class="form-control" placeholder="Email" required="required"/>
              </div>
              <div>
                <input type="password" class="form-control" placeholder="Password" required="required"/>
              </div>
              <div>
                <a class="btn btn-default submit" href="index.html">Submit</a>
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">Already a member ?
                  <a href="#signin" class="to_register"> Log in </a>
                </p>

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i>&nbsp;PayLetter</h1>
                  <p>Copyright &copy; HeewonKim 2018</p>
                </div>
              </div>
            </form>
          </section>
        </div>
      </div>
    </div>
  </body>
</html>