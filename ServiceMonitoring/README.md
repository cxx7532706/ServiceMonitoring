# README #

### Installing Ruby on Rails and running a Local Server for Development ###

1. Install Ruby on Rails on your device with PostgreSQL as the database. 
    * Mac: https://gorails.com/setup/osx/10.10-yosemite
    * Ubuntu: https://gorails.com/setup/ubuntu/15.04
    * Windows (not recommended): http://installrails.com/steps/railsinstaller_windows Note that this link does not show how to install PostgreSQL on Windows.

2. For Windows, install PostgreSQL from this link: http://www.postgresql.org/download/windows/

3. After the PostgreSQL is successfully installed, create a new user called postgres using the command: **createuser -s postgres**. This is needed to create and build our Rails database in PostgreSQL.

4. Download the source code by running git clone https://servicemonitoring@bitbucket.org/servicemonitoring/servicemonitoring.git
    * The login details for bitbucket is:
    * email: servicemonitoring.org@gmail.com
    * password: unimelborange15

5. Open up command prompt on your system and go to the ServiceMonitoring folder.

6. Run **bundle install** to install all relevant gems.

7. Run **rake db:create** to create the database.

8. Run **rake db:seed** to seed the administrator and general survey into the database.

9. Run **rails s** to run the server.

10. Access the server via localhost:3000 in order to access the application.